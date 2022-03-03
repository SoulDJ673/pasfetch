unit uPasfetchAscii;
{$mode objfpc}{$H+}

interface

uses 
 Crt;

Procedure WriteArch;
Procedure WritePopOS;

implementation

// Arch Linux Logo
Procedure WriteArch;
begin
	TextColor(LightBlue);
	writeLn('       /\\       ');
	writeLn('      /  \\      ');
	writeLn('     /\\  \\     ');
	writeLn('    /      \\    ');
	writeLn('   /   ,,   \\   ');
	writeLn('  /   |  |  -\\  ');
	writeLn(' /__-''    ''-__\\ ');	
end;


// PopOS Logo
Procedure WritePopOS;
begin
	TextColor(White);
	writeLn(' ______               ');
	writeLn(' \   _ \        __    ');
	writeLn('  \ \ \ \      / /    ');
	writeLn('   \ \_\ \    / /     ');
	writeLn('    \  ___\  /_/      ');
	writeLn('     \ \    _         ');
	writeLn('    __\_\__(_)_       ');
	writeLn('   (___________)      ');	
end;

end.
