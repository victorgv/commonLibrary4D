unit MyLibrary.FormLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MyLibrary.FormUtil,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.StdCtrls,
  MVCFramework.RESTClient, MVCFramework.RESTClient.Intf;

type
  TMyLibrary_FormLogin = class(TMyLibrary_FormBase)
    la_header: TLayout;
    TitleText: TText;
    Layout1: TLayout;
    ed_username: TEdit;
    ed_password: TEdit;
    Rectangle1: TRectangle;
    sb_Login: TSpeedButton;
    Layout2: TLayout;
    sb_Forgot_Password: TSpeedButton;
    Image1: TImage;
    LA_INFO: TLabel;
    procedure sb_LoginClick(Sender: TObject);
  private
    { Private declarations }
    function validate_fields: boolean; // Just if username are inform, etc
  public
    { Public declarations }
    constructor create(aowner: TComponent); virtual;
  end;

type TMyLibrary_ClassFormLogin = class of TMyLibrary_FormLogin;



implementation

{$R *.fmx}

uses MyLibrary.Core,
     System.JSON,
     MVCFramework.SystemJSONUtils;



constructor TMyLibrary_FormLogin.create(aowner: TComponent);
begin
  inherited;
  LA_INFO.Text := '';
  ed_username.SetFocus;
end;

procedure TMyLibrary_FormLogin.sb_LoginClick(Sender: TObject);
var
  vClientClt: IMVCRESTClient;
  vResponse: IMVCRESTResponse;
  vJSON: TJSONObject;
  vJWT_Token: string;
begin
  if validate_fields then
  begin
    vResponse := MyLibrary_.RestConnection.ProxiedPost('/login', '{"jwtusername":"'+ed_username.Text+'","jwtpassword":"'+ed_password.Text+'"}');

    if vResponse.Success then
    begin
      vJSON := TSystemJSON.StringAsJSONObject(vResponse.Content);
      try
        vJWT_Token := vJSON.GetValue('token').Value;
      finally
        vJSON.Free;
      end;
      MyLibrary_.newSession(vJWT_Token);
      LA_INFO.StyledSettings := LA_INFO.StyledSettings - [TStyledSetting.ssFontColor];
      LA_INFO.TextSettings.FontColor := TAlphaColorRec.Darkgreen;
      LA_INFO.Text := MyLibrary_.UserStrings.getString('ML00001'); // successful login
      close;
    end;
  end;
end;


// Just if username are inform, etc
function TMyLibrary_FormLogin.validate_fields: boolean;
begin
  if ed_username.Text.Trim.Length = 0 then
  begin
    result := false;
    LA_INFO.TextSettings.FontColor := TAlphaColorRec.Red;
    LA_INFO.Text := MyLibrary_.UserStrings.getString('ML00004');
    ed_username.SetFocus;
  end
  else if ed_password.Text.Trim.Length = 0 then
  begin
    result := false;
    LA_INFO.TextSettings.FontColor := TAlphaColorRec.Red;
    LA_INFO.Text := MyLibrary_.UserStrings.getString('ML00005');
    ed_password.SetFocus;
  end;



end;

end.
