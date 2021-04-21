unit MyLibrary.DMVCF.Connection;

interface

uses System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework;

type
  TMyLibrary_RestClient = class
  private

  public
    { Public declarations }
  end;


implementation

{$R *.dfm}


uses
  MyLibrary.DMVCF.Controller.Public_V01,
  MVCFramework.Commons,
  MVCFramework.Middleware.StaticFiles;


end.
