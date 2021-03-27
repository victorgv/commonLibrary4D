unit MyLibrary.Core;

interface

uses MyLibrary.FormLogin, System.Classes, MyLibrary.Session;

type
  TMyLibrary = class
  private
    fSession: TMyLibrary_Session;
  public
    function DoLogin(p_LoginFormClass: TMyLibrary_ClassFormLogin): boolean;

    procedure newSession;
    //
    property Session: TMyLibrary_Session read fSession;
    //
    constructor create;
  end;

var MyLibrary_MASTER: TMyLibrary;

implementation

{ TMyLibrary }

constructor TMyLibrary.create;
begin
  inherited;
  fSession := NIL;
end;

function TMyLibrary.DoLogin(p_LoginFormClass: TMyLibrary_ClassFormLogin): boolean;
var
  formInstance: TMyLibrary_FormLogin;
begin
  formInstance := p_LoginFormClass.Create(nil);
  try
    formInstance.show;

  finally
    formInstance.free;
  end;
end;

procedure TMyLibrary.newSession;
begin
  fSession := TMyLibrary_Session.Create;
end;

initialization
  MyLibrary_MASTER := TMyLibrary.Create;

finalization
  MyLibrary_MASTER.Free;


end.
