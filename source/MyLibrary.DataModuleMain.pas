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
  end;

var
  MyLibrary_DataModuleMain: TMyLibrary_DataModuleMain;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
