unit CL4D.Properties;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB;



type
   ICL4DProperties = interface
     ['{9090DDD2-3431-4A0C-AEDB-11153C4AD5D9}']
     function TryGetValue(const Key: String; out Value: String): Boolean;
     function ContainsKey(const Key: String): Boolean;
     function GetKey(const Key: String): String;
     procedure AddOrSetValue(const Key, Value: String);
     function GetCount: Integer;
     property Items[const Key: String]: String read GetKey; default;
   end;

type
  TCL4DPropertiesBase = class(TInterfacedObject, ICL4DProperties)
  private
    fDictionary: TDictionary<String, String>;
  protected
    procedure AddOrSetValue(const Key, Value: String);
    function GetKey(const Key: String): String;
    procedure LoadFromFile(const FileName: String);
  public
    property Items[const Key: String]: String read GetKey;

    constructor Create;
    destructor Destroy; override;

    function TryGetValue(const Key: String; out Value: String): Boolean;
    function ContainsKey(const Key: String): Boolean;
    function GetCount: Integer;

  end;

type
  TCL4DProperties = class(TCL4DPropertiesBase, ICL4DProperties)
  public
    constructor Create; overload;   // I�m Feeling Lucky... first search file application.properties, [TO-DO] next config.ini, ...
    constructor Create(DataSet: TDataSet); overload;
  end;

  // Invoke a singleton instance
  function getSingletoneApplicationProperties: ICL4DProperties;



implementation

uses
  System.Classes;


var
  _SingletoneApplicationProperties: ICL4DProperties;

function getSingletoneApplicationProperties: ICL4DProperties;
begin
  if not assigned(_SingletoneApplicationProperties) then
    _SingletoneApplicationProperties := TCL4DProperties.Create;
  Result := _SingletoneApplicationProperties;
end;

{ TCL4DCustomProperties }

constructor TCL4DPropertiesBase.Create;
begin
  inherited Create;
  fDictionary := TDictionary<String, String>.Create;
end;

destructor TCL4DPropertiesBase.Destroy;
begin
  fDictionary.Free;
  inherited Destroy;
end;

procedure TCL4DPropertiesBase.AddOrSetValue(const Key, Value: String);
begin
  fDictionary.Add(Key, Value);
end;

function TCL4DPropertiesBase.ContainsKey(const Key: String): Boolean;
begin
  Result := fDictionary.ContainsKey(Key);

end;

function TCL4DPropertiesBase.GetCount: Integer;
begin
  Result := fDictionary.Count;
end;

function TCL4DPropertiesBase.GetKey(const Key: String): String;
begin
  Result := fDictionary[Key];
end;

procedure TCL4DPropertiesBase.LoadFromFile(const FileName: String);
var
  rec: string;
  _file: TextFile;
begin
  AssignFile(_file,FileName);
  try
    Reset(_file);
    while not Eof(_file) do
    begin
      Readln(_file, rec);
      if (rec.Trim <> '') AND (rec.Trim.StartsWith('#')=FALSE) then
        fDictionary.Add(rec.Split(['='])[0].Trim, rec.Split(['='])[1].Trim);
    end;
  finally
    CloseFile(_file);
  end;
end;

function TCL4DPropertiesBase.TryGetValue(const Key: String; out Value: String): Boolean;
begin
  Result := fDictionary.TryGetValue(Key, Value);
end;

{ TCL4DProperties }
// Load list of properties from dataset, it must get register with 2 parameters named: KEY, VALUE
constructor TCL4DProperties.Create(DataSet: TDataSet);
begin
  inherited Create;
  while not DataSet.Eof do
  begin
    fDictionary.AddOrSetValue(DataSet.fieldByName('KEY').AsString, DataSet.fieldByName('VALUE').AsString);
    DataSet.next;
  end;
end;

// I�m Feeling Lucky... first search file application.properties, [TO-DO] next config.ini, ...
constructor TCL4DProperties.Create;
var
  rec: string;
  _file: TextFile;
begin
  inherited Create;

  // (1) TRY to load "application.properties"
  try
    LoadFromFile('application.propertiesZZ');
  except
    on e: EInOutError  do
    begin
      if e.ErrorCode <> 103 then // We want to continue if file not found
        Raise;
    end;
  end;




end;

end.
