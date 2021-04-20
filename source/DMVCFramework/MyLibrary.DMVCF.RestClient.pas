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
  WebModuleClass_MyLibrary_DMVCF_WebModule: TComponentClass = TMyLibrary_DMVCF_WebModule;

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
      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout] := '0';
      //default content-type
      Config[TMVCConfigKey.DefaultContentType] := TMVCConstants.DEFAULT_CONTENT_TYPE;
      //default content charset
      Config[TMVCConfigKey.DefaultContentCharset] := TMVCConstants.DEFAULT_CONTENT_CHARSET;
      //unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction] := 'false';
      //enables or not system controllers loading (available only from localhost requests)
      Config[TMVCConfigKey.LoadSystemControllers] := 'true';
      //default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := 'html';
      //view path
      Config[TMVCConfigKey.ViewPath] := 'templates';
      //Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount] := '20';
      //Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature] := 'true';
      //Enable X-Powered-By Header in response
      Config[TMVCConfigKey.ExposeXPoweredBy] := 'true';
      // Max request size in bytes
      Config[TMVCConfigKey.MaxRequestSize] := IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);


    end);

  // MVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/app', '.\www\public_html')); // Web files
  // MVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/images', '.\www\public_images', 'database.png')); // Image files

  MVC.AddController(TMyLibrary_DMVCF_Controller_Public);
end;

procedure TMyLibrary_DMVCF_WebModule.WebModuleDestroy(Sender: TObject);
begin
  MVC.free;
end;

end.
