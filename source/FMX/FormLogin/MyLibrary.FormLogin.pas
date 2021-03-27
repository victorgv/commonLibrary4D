unit MyLibrary.FormLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MyLibrary.FormUtil,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts;

type
  TMyLibrary_FormLogin = class(TMyLibrary_FormBase)
    la_header: TLayout;
    FormLayout: TLayout;
    UsernameEdit: TEdit;
    UsernameUnderLine: TLine;
    UserImage: TImage;
    PasswordEdit: TEdit;
    PasswordUnderLine: TLine;
    LockImage: TImage;
    LoginRectBTN: TRectangle;
    LoginButtonText: TText;
    TitleText: TText;
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
