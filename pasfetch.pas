program pasfetch;
{$mode objfpc}{$H+}

uses 
Crt, uPasfetchUtils;

var 
  // A record to store system information
  Info 		 : packed record
    OS    	 : packed array [1..40] of char;
    HostNAme : packed array [1..40] of char;
    Kernel   : packed array [1..40] of char;
    Uptime   : packed array [1..20] of char;
    Memory   : packed array [1..20] of char;

  end;


begin

  // Get system information and place it in record
  with info do
    begin
      OS   	   := GetOS;
      HostName := GetHostName;
      Kernel   := GetKernel;
      Uptime   := GetUptime;
      Memory   := GetRamUsage;
    end;

  //Clear the screen
  ClrScr;

  //Check what operating system and write logo
  WriteOSLogo(info.OS);


  // Info Names
  TextColor(Yellow);
  HighVideo;
  GoToXY(20, 2);
  write(' OS:');
  GoToXY(20, 3);
  write(' HOST:');
  GoToXY(20, 4);
  write(' KERNEL:');
  GoToXY(20, 5);
  write(' UPTIME:');
  GoToXY(20, 6);
  write(' MEMORY:');
  NormVideo;


  // Info
  LowVideo;
  TextColor(White);
  GoToXY(30, 2);
  writeln(info.OS);

  GoToXY(30, 3);
  write(info.HostName);

  GoToXY(30, 4);
  write(info.Kernel);

  GoToXY(30, 5);
  write(info.Uptime);

  GoToXY(30, 6);
  write(info.Memory);

  // Color blocks
  GoToXY(32, 7);
  TextColor(LightBlue);
  writeLn('▄');

  GoToXY(34, 7);
  TextColor(LightCyan);
  writeLn('▄');

  GoToXY(36, 7);
  TextColor(LightRed);
  writeLn('▄');

  GoToXY(38, 7);
  TextColor(LightMagenta);
  writeLn('▄');

  GoToXY(40, 7);
  TextColor(LightGray);
  writeLn('▄');

  GoToXY(42, 7);
  TextColor(Cyan);
  writeLn('▄');

  // end
  TextColor(White);
  GoToXY(1,11);
  writeLn('');

end.
