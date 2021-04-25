unit MyLibrary.Core;

interface

uses MyLibrary.FormLogin,
     System.Classes,
     MyLibrary.Session,
     FMX.Forms,
     MyLibrary.DMVCF.Connection,
     MyLibrary.UserLanguageStrings;

type
  TMyLibrary = class
  private
    fSession: TMyLibrary_Session;
    fRestConnection: TMyLibrary_ProxyRestClient;
    fUserStrings: TMyLibrary_UserLanguageStrings;
  public
    function DoLogin(p_LoginFormClass: TMyLibrary_ClassFormLogin): boolean;


    procedure newSession(const p_JWT_Token: string);
    //
    property Session: TMyLibrary_Session read fSession;
    property RestConnection:TMyLibrary_ProxyRestClient read fRestConnection;
    property UserStrings: TMyLibrary_UserLanguageStrings read fUserStrings;
    //
    constructor create;
    destructor destroy;
  end;

var MyLibrary_: TMyLibrary;

implementation

uses
  System.UITypes;

{ TMyLibrary }

constructor TMyLibrary.create;
begin
  inherited;
  fRestConnection := TMyLibrary_ProxyRestClient.create;
  fSession := NIL;
  fUserStrings := TMyLibrary_UserLanguageStrings.create(lgEnglish);
end;

destructor TMyLibrary.destroy;
begin
  fRestConnection.Free;
  fUserStrings.Free;
  inherited;
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
  MyLibrary_ := TMyLibrary.Create;

finalization
  MyLibrary_.Free;


end.
