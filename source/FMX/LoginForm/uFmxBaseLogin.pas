unit uFmxBaseLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MyLibrary.FormUtil,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts;

type
  TFmxBaseLogin = class(TMyLibraryFormBase)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmxBaseLogin: TFmxBaseLogin;

implementation

{$R *.fmx}



end.
