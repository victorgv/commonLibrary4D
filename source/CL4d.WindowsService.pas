unit CL4D.WindowsService;

interface

uses
  Vcl.SvcMgr;

type
  TCL4DServiceHelper = class helper for TService
    procedure SetDescription(const Desc: String);
  end;

implementation

uses
  System.Win.Registry,
  Winapi.Windows;

{ TCL4DServiceHelper }
// Set a description on Windows Service
procedure TCL4DServiceHelper.SetDescription(const Desc: String);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, false) then
    begin
      Reg.WriteString('Description', Desc);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

end;

end.
