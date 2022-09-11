unit uPasfetchUtils;
{$MODE OBJFPC}{$H+}{$J-}

interface

uses
	Classes, SysUtils, uPasfetchAscii;

	// Public functions for Pasfetch
procedure WriteOSLogo(strOS: string);
function GetHostName(): string;
function GetRamUsage(): string;
function GetUptime(): string;
function GetOS(): string;
function GetKernel(): string;


implementation


procedure WriteOSLogo(strOS: string);
var
	s: integer;
begin
	// Truncate OS name to first word
	s := pos(' ', strOS);
	SetLength(strOS, s-1);

	case lowercase(strOS) of
	'artix' : WriteArtix;
	'arch' : WriteArch;
	'pop' : WritePopOS;
else
	WriteOther;
		end;
	end;

	// Function to Extract a string between 2 strings
function ExtractString(StrSource, StrFirst, StrLast: string): string;
begin
	Result := Copy(StrSource, Pos(StrFirst, StrSource) + Length(StrFirst),
	Pos(StrLast, StrSource) - (Pos(StrFirst, StrSource) + Length(StrFirst)));
end;


// Function to remove all instants of a char from string
function StripChars(StrSource, StrRemove: string): string;
var
	i: integer;
begin
	Result := StrSource;
	repeat
		i := pos(StrRemove, Result);
		if i > 0 then
			Delete(Result, i, 1);
		until pos(StrRemove, Result) = 0;
	end;


	//Get hostname
function GetHostName(): string;
var
	strHostName: string;
	txtHostName: TextFile;
begin
	try
		AssignFile(txtHostName, '/proc/sys/kernel/hostname');
		try
			Reset(txtHostName);
			ReadLn(txtHostName, strHostName);
		finally
			CloseFile(txtHostName);
			Result := strHostName;
		end;
	except
		on E: EInOutError do begin
			Result := 'Unknown';
		end;
	end;
end;


// Get Memory and usage
function GetRamUsage(): string;
var
	strTmp, strMemTotal, strMemFree, strShmem, strBuffers, strCached,
	strSRclaimable: string;
	intMemUsage, intTotalMem: single;
	slMemInfo: TStringList;
begin
	Result := 'Error';
	// Set the name of the file that will be read
	slMemInfo := TStringList.Create;
	try
		slMemInfo.LoadFromFile('/proc/meminfo');
		try
			// Process MemTotal
			strTmp := slMemInfo.Strings[0];
			strMemTotal := Trim(ExtractString(strTmp, 'MemTotal:', 'kB'));

			// Process MemFree
			strTmp := slMemInfo.Strings[1];
			strMemFree := Trim(ExtractString(strTmp, 'MemFree:', 'kB'));

			// Process Buffers
			strTmp := slMemInfo.Strings[3];
			strBuffers := Trim(ExtractString(strTmp, 'Buffers:', 'kB'));

			// Process Cached
			strTmp := slMemInfo.Strings[4];
			strCached := Trim(ExtractString(strTmp, 'Cached:', 'kB'));

			// Process Shmem
			strTmp := slMemInfo.Strings[20];
			strShmem := Trim(ExtractString(strTmp, 'Shmem:', 'kB'));

			// Process SReclaimable
			strTmp := slMemInfo.Strings[23];
			strSRclaimable := Trim(ExtractString(strTmp, 'SReclaimable:', 'kB'));

			// Calc Mem Total
			intTotalMem := StrToFloat(strMemTotal);

			// Calc Mem Usage
			intMemUsage := (intTotalMem - StrToFloat(strMemFree) - StrToFloat(strBuffers) - 
			StrToFloat(strCached) - StrToFloat(strSRclaimable));
		finally
			slMemInfo.Free;
			Result := Format('%.2fGB / %.2fGB', [intMemUsage / (1024 * 1024), intTotalMem / (1024 * 1024)]);
		end;

	except
		on E: EInOutError do
			Result := 'Unknown';
		on E: EStringListError do
			Result := 'Unknown';
	end;
end;


// Get uptime using GetTickCount64
function GetUptime(): string;
var
	aDatetime: TDateTime;
begin
	aDatetime := (GetTickCount64 / SecsPerDay / MSecsPerSec);
	Result := Format('%d days, %s', [Trunc(aDatetime),
	FormatDateTime('hh:nn:ss', Frac(aDatetime))]);
end;


// Get Kernel
function GetKernel(): string;
var
	strOSType, strOSRelease: string;
	txtOStype, txtOSRelease: TextFile;
begin
	try
		AssignFile(txtOStype, '/proc/sys/kernel/ostype');
		AssignFile(txtOSRelease, '/proc/sys/kernel/osrelease');
		try
			Reset(txtOStype);
			Reset(txtOSRelease);

			ReadLn(txtOStype, strOSType);
			ReadLn(txtOSRelease, strOSRelease);

		finally
			CloseFile(txtOStype);
			CloseFile(txtOSRelease);
		end;
		Result := strOSType + '  ' + strOSRelease;
	except
		on E: EInOutError do begin
			writeln('File handling error occurred. Details: ', E.Message);
			Result := 'Unknown';
		end;
	end;
end;


// Get OS
function GetOS(): string;
var
	strOS, strTmp: string;
	slOS: TStringList;
	i: integer;
begin
	Result := 'Error';
	slOS := TStringList.Create;
	try
		slOS.LoadFromFile('/etc/os-release');
		try
			for i := 0 to pred(slOS.Count) do
			begin
				strTmp := slOS.Strings[i];
				if pos('_NAME="', slOS.Strings[i]) > 6 then
				begin
					strOS := strTmp;
					Delete(strOS, 1, 13);
					strOS := StripChars(strOS, '"');
				end;
			end;
		finally
			slOS.Free;
		end;
	except
		on E: EInOutError do begin
			writeln('File handling error occurred. Details: ', E.Message);
			strOS := 'Unknown';
		end;
		on E: EFileNotFoundException do begin
			strOS := 'Unknown';
		end;
		on E: EFOpenError do begin
			strOS := 'Unknown';
		end;
	end;
	Result := strOS;
end;

end.
