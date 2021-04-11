unit MyLibrary.DMVCF.WebModule;

interface

uses System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework;

type
  TMyLibrary_DMVCF_WebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);

  private
    MVC: TMVCEngine;

  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TMyLibrary_DMVCF_WebModule;

implementation

{$R *.dfm}


uses
  MyLibrary.DMVCF.Controller.Public_V01,
  MVCFramework.Commons,
  MVCFramework.Middleware.StaticFiles;

procedure TMyLibrary_DMVCF_WebModule.WebModuleCreate(Sender: TObject);
begin
  MVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      Config[TMVCConfigKey.ViewPath] := '.\www\public_html';
    end);

  // Web files
  MVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/app', '.\www\public_html'));

  // Image files
  MVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/images', '.\www\public_images', 'database.png'));

  MVC.AddController(TMyLibrary_DMVCF_Controller_Public);
end;

procedure TMyLibrary_DMVCF_WebModule.WebModuleDestroy(Sender: TObject);
begin
  MVC.free;
end;

end.
