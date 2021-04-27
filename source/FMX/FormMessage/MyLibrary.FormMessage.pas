unit MyLibrary.FormMessage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MyLibrary.FormUtil,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.StdCtrls,
  MVCFramework.RESTClient, MVCFramework.RESTClient.Intf;

type
  TMyLibrary_FormMessage = class(TMyLibrary_FormBase)
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
  public
    { Public declarations }
    constructor create(aowner: TComponent); virtual;
  end;

type TMyLibrary_ClassFormLogin = class of TMyLibrary_FormMessage;



implementation

{$R *.fmx}

uses MyLibrary.Core,
     System.JSON,
     MVCFramework.SystemJSONUtils;



constructor TMyLibrary_FormMessage.create(aowner: TComponent);
begin
  inherited;
  LA_INFO.Text := '';
end;

procedure TMyLibrary_FormMessage.sb_LoginClick(Sender: TObject);
var
  vClientClt: IMVCRESTClient;
  vResponse: IMVCRESTResponse;
  vJSON: TJSONObject;
  vJWT_Token: string;
begin
  //vClientClt := TMVCRESTClient.New.BaseURL('http://192.168.1.16', 8080);
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
  end
  else
  begin
    ShowMessage(
      'HTTP ERROR: ' + vResponse.StatusCode.ToString + sLineBreak +
      'HTTP ERROR MESSAGE: ' + vResponse.StatusText + sLineBreak +
      'ERROR MESSAGE: ' + vResponse.Content);
    Exit;
  end;

end;



end.
