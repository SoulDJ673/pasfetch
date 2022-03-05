unit uPasfetchAscii;

{$MODE OBJFPC}{$H+}{$J-}

interface

uses
  uAnsiCrt;

procedure WriteArch;
procedure WritePopOS;

implementation


// Arch Linux Logo
procedure WriteArch;
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
procedure WritePopOS;
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
