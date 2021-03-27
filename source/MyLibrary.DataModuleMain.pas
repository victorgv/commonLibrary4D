unit MyLibrary.DataModuleMain;

interface

uses
  System.SysUtils, System.Classes;

type
  TMyLibrary_DataModuleMain = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function ApplicationNAME: string; virtual; abstract;
    function ApplicationCODE: string; virtual; abstract;
  end;

var
  MyLibrary_DataModuleMain: TMyLibrary_DataModuleMain;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
