program pasfetch(input, output, stdErr);

{$MODE OBJFPC}{$H+}{$J-}

uses
	uPasfetchUtils,
	uAnsiCrt;
var
	// A record to store system information
	Info: packed record
		OS: packed array [1..40] of char;
		HostName: packed array [1..40] of char;
		Kernel: packed array [1..40] of char;
		Uptime: packed array [1..20] of char;
		Memory: packed array [1..20] of char;

	end;

	i, iBoxPos: Integer;

begin
	// Get system information and place it in record
		with info do
		begin
			OS := GetOS;
			HostName := GetHostName;
			Kernel := GetKernel;
			Uptime := GetUptime;
			Memory := GetRamUsage;
		end;

		//Clear the screen
		ClrScr;

		//Check what operating system and write logo
		WriteOSLogo(info.OS);


		// Info Names
		TextColor(Yellow);
		GoToXY(20, 2);
		Write(''); // OS
		GoToXY(20, 3);
		Write(''); // HOST
		GoToXY(20, 4);
		Write(''); // KERNEL
		GoToXY(20, 5);
		Write(''); // UPTIME
		GoToXY(20, 6);
		Write(''); // MEMORY
		//NormVideo;

		// Info
		TextColor(White);
		GoToXY(22, 2);
		writeln(info.OS);

		GoToXY(22, 3);
		Write(info.HostName);

		GoToXY(22, 4);
		Write(info.Kernel);

		GoToXY(22, 5);
		Write(info.Uptime);

		GoToXY(22, 6);
		Write(info.Memory);

		// Color blocks 
		iBoxPos:= 20;

		for i:= 1 to 12 do
		begin
			GotoXY(iBoxPos,7);
			Textcolor(90+i);
			writeLn('▄');
			inc(iBoxPos,2);
		end;

		Reset;
		GoToXY(1, 10);

end.
