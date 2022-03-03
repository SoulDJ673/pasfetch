unit uPasfetchUtils;
{$mode objfpc}{$H+}

interface

uses 
Classes, Sysutils, uPasfetchAscii;

// Public functions for Pasfetch
Procedure WriteOSLogo(strOS: String);
function GetHostName(): String;
function GetRamUsage(): String;
function GetUptime(): String;
function GetOS(): String;
function GetKernel(): String;


implementation


Procedure WriteOSLogo(strOS: String);
begin
  if pos('Pop', strOS) <> 0 then
    // Write the popos logo
    WritePopOS
  else
    // Write the arch logo
    WriteArch;
end;


// Function to Extract a string between 2 strings
function ExtractString(StrSource, StrFirst, StrLast: String): String;
begin
  result := Copy(StrSource,Pos(StrFirst,StrSource)+Length(StrFirst),Pos(StrLast,StrSource)-(Pos(StrFirst,StrSource)+Length(StrFirst)));
end;


// Function to remove all instants of a char from string
function StripChars(StrSource, StrRemove: String): String;
var 
  i: Integer;
begin
  Result := StrSource;
  repeat
    i := pos(StrRemove, Result);
    if i > 0 then
      delete(Result, i, 1);
  until pos(StrRemove, Result) = 0;
end;


//Get hostname
function GetHostName(): String;
var 
  strHostName: String;
  txtHostName: TextFile;
begin
  AssignFile(txtHostName, '/proc/sys/kernel/hostname');
  try
    Reset(txtHostName);
    ReadLn(txtHostName, strHostName);
  finally
    CloseFile(txtHostName);
  end;
 Result := strHostName;
end;


// Get Memory and usage
function GetRamUsage(): String;
var 
  strTmp, strMemTotal, strMemFree, strShmem, strBuffers, strCached, strSRclaimable : String;
  intMemUsage, intTotalMem : Single;
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
      intTotalMem := StrToFloat(strMemTotal) + StrToFloat(strShmem);

      // Calc Mem Usage
      intMemUsage := (intTotalMem - StrToFloat(strMemFree) - StrToFloat(strBuffers) - StrToFloat(strCached) - StrToFloat(strSRclaimable));
    Finally
      slMemInfo.free;
	end;

  except
	on E: EInOutError do
        writeln('File handling error occurred. Details: ', E.Message);
  end;

 Result := Format('%.2fGB / %.2fGB', [intMemUsage / (1024*1024), (intTotalMem - StrToFloat(strShmem)) / (1024*1024)]);
end;


// Get uptime using GetTickCount64
function GetUptime(): String;
var 
  aDatetime : TDateTime;
begin
  aDatetime := (GetTickCount64  / SecsPerDay / MSecsPerSec);
  Result := Format('%d days, %s', [Trunc(aDatetime), FormatDateTime('hh:nn:ss', Frac(aDatetime))]) ;
end;


// Get Kernel
function GetKernel(): String;
var 
  strOSType, strOSRelease: String;
  txtOStype, txtOSRelease: TextFile;
begin
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
end;


// Get OS
function GetOS(): String;
var 
  strOS, strTmp: String;
  slOS: TStringList;
  i: Integer;
begin
  Result := 'Error';
  slOS := TStringList.Create;
  try
    slOS.LoadFromFile('/etc/os-release');
    try
      for i:= 0 to pred(slOS.Count) do
        begin
          strTmp := slOS.Strings[i];
          if pos('_NAME="', slOS.Strings[i]) > 6 then
            begin
              strOS := strTmp;
              delete(strOS,1, 13);
              strOS := StripChars(strOS, '"');
            end;
        end;
    finally
      slOS.free;
	end;
	except
	 on E: EInOutError do
        writeln('File handling error occurred. Details: ', E.Message);
  end;
 Result := strOS;
end;

end.
