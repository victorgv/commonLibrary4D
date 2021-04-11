unit MyLibrary.FormLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MyLibrary.FormUtil,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.StdCtrls;

type
  TMyLibrary_FormLogin = class(TMyLibrary_FormBase)
    la_header: TLayout;
    TitleText: TText;
    Layout1: TLayout;
    ed_username: TEdit;
    ed_password: TEdit;
    Rectangle1: TRectangle;
    sb_doLogin: TSpeedButton;
    Layout2: TLayout;
    sb_Forgot_Password: TSpeedButton;
    procedure LoginButtonTextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TMyLibrary_ClassFormLogin = class of TMyLibrary_FormLogin;



implementation

{$R *.fmx}

uses MyLibrary.Core;

procedure TMyLibrary_FormLogin.LoginButtonTextClick(Sender: TObject);
begin
  MyLibrary_MASTER.newSession;
end;

end.
