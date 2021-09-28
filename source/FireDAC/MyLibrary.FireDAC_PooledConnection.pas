unit MyLibrary.FireDAC_PooledConnection;

interface

const
  c_ConnectionDefName = 'MyLibrary_Conn';

implementation

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils;

procedure TMyLibrary_doCreate_Pooled_Connection(const p_SERVER, p_DATABASE, p_USERNAME, p_PASSWORD: String; p_PORT, p_NumMaxPool: Integer); // PostgerSql conn
var
  LParams: TStringList;
begin
  LParams := TStringList.Create;
  try
    LParams.Add('Database='+p_DATABASE);
    LParams.Add('Protocol=TCPIP');
    LParams.Add('Server='+p_SERVER);
    LParams.Add('User_Name='+p_USERNAME);
    LParams.Add('Password='+p_PASSWORD);
    LParams.Add('Pooled=True');
    LParams.Add('Port='+intToStr(p_Port));
    LParams.Add('POOL_MaximumItems='+intToStr(p_NumMaxPool));
    FDManager.AddConnectionDef(c_ConnectionDefName, 'PG', LParams);
  finally
    LParams.Free;
  end;
end;



end.
