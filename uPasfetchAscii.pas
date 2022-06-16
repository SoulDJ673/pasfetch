unit uPasfetchAscii;

{$MODE OBJFPC}{$H+}{$J-}

interface

uses
  uAnsiCrt;

procedure WriteArch;
procedure WriteArtix;
procedure WritePopOS;
procedure WriteOther;

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

// Artix Linux Logo
procedure WriteArtix;
begin

  TextColor(LightBlue);
  writeLn('      /\      ');
  writeLn('     /  \     ');
  writeLn('    /`''.,\    ');
  writeLn('   /     '',   ');
  writeLn('  /      ,`\  ');
  writeLn(' /   ,.''`.  \ ');
  writeLn('/.,''`     `''.\');

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

// Unknown Logo
procedure WriteOther;
begin

  TextColor(White);
  writeLn('               ');
  writeLn('  o    |~~~|   ');
  writeLn(' /\\_  _|   |  ');
  writeLn(' \\__`[_    |  ');
  writeLn(' [] \\,/|___|  ');
  writeLn('               ');
  writeLn('-David S. Issel');
  writeLn('               ');

end;

end.
