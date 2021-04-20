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
    procedure sb_LoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TMyLibrary_ClassFormLogin = class of TMyLibrary_FormLogin;



implementation

{$R *.fmx}

uses MyLibrary.Core,
     System.JSON,
     MVCFramework.SystemJSONUtils;



procedure TMyLibrary_FormLogin.sb_LoginClick(Sender: TObject);
var
  vClientClt: IMVCRESTClient;
  vResponse: IMVCRESTResponse;
  vJSON: TJSONObject;
  vJWT_Token: string;
begin
  vClientClt := TMVCRESTClient.New.BaseURL('http://localhost', 8080);
  vResponse := vClientClt.Post('/login', '{"jwtusername":"'+ed_username.Text+'","jwtpassword":"'+ed_password.Text+'"}');
  if not vResponse.Success then
  begin
    ShowMessage(
      'HTTP ERROR: ' + vResponse.StatusCode.ToString + sLineBreak +
      'HTTP ERROR MESSAGE: ' + vResponse.StatusText + sLineBreak +
      'ERROR MESSAGE: ' + vResponse.Content);
    Exit;
  end;

  vJSON := TSystemJSON.StringAsJSONObject(vResponse.Content);
  try
    vJWT_Token := vJSON.GetValue('token').Value;
  finally
    vJSON.Free;
  end;


  MyLibrary_MASTER.newSession(vJWT_Token);
end;



end.
