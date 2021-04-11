unit MyLibrary.Core;

interface

uses MyLibrary.FormLogin, System.Classes, MyLibrary.Session, FMX.Forms;

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
    formInstance.RunFormAsModal(procedure()  // Modal http://docwiki.embarcadero.com/RADStudio/Sydney/en/Using_FireMonkey_Modal_Dialog_Boxes
      begin

      end
    );
    //***Application.mainform := formInstance;

  finally
    // formInstance.free; *** It must have caFree
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
