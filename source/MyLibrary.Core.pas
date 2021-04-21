unit MyLibrary.Core;

interface

uses MyLibrary.FormLogin, System.Classes, MyLibrary.Session, FMX.Forms;

type
  TMyLibrary = class
  private
    fSession: TMyLibrary_Session;
  public
    function DoLogin(p_LoginFormClass: TMyLibrary_ClassFormLogin): boolean;

    procedure newSession(const p_JWT_Token: string);
    //
    property Session: TMyLibrary_Session read fSession;
    //
    constructor create;
  end;

var MyLibrary_MASTER: TMyLibrary;

implementation

uses
  System.UITypes;

{ TMyLibrary }

constructor TMyLibrary.create;
begin
  inherited;
  fSession := NIL;
end;

function TMyLibrary.DoLogin(p_LoginFormClass: TMyLibrary_ClassFormLogin): boolean;
var
  formInstance: TMyLibrary_FormLogin;
  return_value: boolean;
begin
  formInstance := p_LoginFormClass.Create(nil);
  try
    formInstance.RunFormAsModal(procedure(ModalResult: TModalResult)  // Modal http://docwiki.embarcadero.com/RADStudio/Sydney/en/Using_FireMonkey_Modal_Dialog_Boxes
      begin
        return_value := ModalResult = mrOk;
      end
    );
    result := return_value;
  finally
    // formInstance.free; *** It must have caFree
    result := false;
  end;
end;

procedure TMyLibrary.newSession(const p_JWT_Token: string);
begin
  fSession := TMyLibrary_Session.Create(p_JWT_Token);
end;

initialization
  MyLibrary_MASTER := TMyLibrary.Create;

finalization
  MyLibrary_MASTER.Free;


end.
