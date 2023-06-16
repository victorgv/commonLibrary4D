unit CL4D.System;

interface

uses
  Winapi.Windows;

type
  TCL4DSystem = class
    class function GetComputerName: String;
  end;

implementation



{ TCL4DServiceHelper }
// Set a description on Windows Service
class function TCL4DSystem.GetComputerName: String;
var
  LComputerName: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  LSize: DWORD;
begin
  LSize := Length(LComputerName);
  if Winapi.Windows.GetComputerName(LComputerName, LSize) then
    SetString(Result, LComputerName, LSize)
  else
    Result := '';
end;

end.
