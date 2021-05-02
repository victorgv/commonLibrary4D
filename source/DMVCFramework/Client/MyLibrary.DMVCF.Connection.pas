unit MyLibrary.DMVCF.Connection;

interface

uses System.SysUtils,
     System.Classes,
     MVCFramework.RESTClient.Intf,
     MVCFramework.RESTClient,
     MVCFramework.Commons,
     FMX.Dialogs;

// This is like a proxy pattern in order to control the connection balanced between servers if one of those servers is down
type
  TMyLibrary_ProxyRestClient = class(TObject)
  private
    fListOfSERVERS: TStringList;
    fRestClient: IMVCRESTClient;

    procedure changeToNextServer;
    procedure manageConnectionResponseNotSuccess_and_Raise(const aResource: string; p_response: IMVCRESTResponse);
    procedure manageConnectionException_and_Raise(const aResource: string; e: Exception);
  public
    { Public declarations }
    // Methods that are proxied
    function ProxiedPost(const aResource: string; const aBody: string = '';
      const aContentType: string = TMVCMediaType.APPLICATION_JSON): IMVCRESTResponse; overload;

    //
    constructor create; virtual;
    destructor destroy; virtual;
  end;

type
   EMyLibrary_Connection = class(Exception)
   private
    fCODE: String;
    fMessage: String;
    fAditionalInfo: String;
   public
     property CODE: String read fCODE;
     property Message: string read FMessage;
     property AditionalInfo: string read fAditionalInfo;

     constructor create(const p_CODE, p_Message, p_AditionalInfo: string);
   end;

implementation






{ TMyLibrary_ProxyRestClient }

uses MyLibrary.Core;

procedure TMyLibrary_ProxyRestClient.changeToNextServer;
var
  i: integer;
begin
  i := fListOfSERVERS.IndexOf(fRestClient.BaseURL);
  fRestClient := NIL; // This line will free the instance
  fRestClient := TMVCRESTClient.Create;
  //fRestClient.BaseURL(fListOfSERVERS.Strings[System.Random(fListOfSERVERS.Count)]); // Assign one random server

  if i = fListOfSERVERS.Count - 1 then fRestClient.BaseURL(fListOfSERVERS.Strings[0])
  else fRestClient.BaseURL(fListOfSERVERS.Strings[i + 1]);
  showmessage(fRestClient.BaseURL);
end;

constructor TMyLibrary_ProxyRestClient.create;
begin
  inherited;

  fListOfSERVERS := TStringList.Create;
  fListOfSERVERS.Add('http://localhost:8080');
  fListOfSERVERS.Add('http://192.168.1.16:8080');
  fListOfSERVERS.Add('http://servidor_fake:8080');

  fRestClient := TMVCRESTClient.Create;
  fRestClient.BaseURL(fListOfSERVERS.Strings[System.Random(fListOfSERVERS.Count)]); // Assign one random server
end;

destructor TMyLibrary_ProxyRestClient.destroy;
begin
  fRestClient := NIL;
  inherited;
end;

procedure TMyLibrary_ProxyRestClient.manageConnectionException_and_Raise(const aResource: string; e: Exception);
var
  v_CODE: string;
  v_Message: string;
  v_AditionalInfo: string;
begin
  v_AditionalInfo := 'MESSAGE: ' + e.Message;
  //
  if aResource = 'XXXX' then
  begin
    v_code := 'ML00XXX'; // to-do?
    v_Message := '???';
  end
  else
  begin
    v_code := 'ML00003'; // Something went wrong
    v_Message := MyLibrary_.UserStrings.getString(v_code);
  end;
  //
  raise EMyLibrary_Connection.create(v_CODE, v_Message, v_AditionalInfo);
end;

// If NOT response.success
procedure TMyLibrary_ProxyRestClient.manageConnectionResponseNotSuccess_and_Raise(const aResource: string; p_response: IMVCRESTResponse);
var
  v_CODE: string;
  v_Message: string;
  v_AditionalInfo: string;
begin
  v_AditionalInfo := 'HTTP ERROR: ' + p_response.StatusCode.ToString + sLineBreak +
                     'HTTP ERROR MESSAGE: ' + p_response.StatusText + sLineBreak +
                     'ERROR MESSAGE: ' + p_response.Content;
  //
  if aResource = '/login' then
  begin
    v_code := 'ML00002'; // User or password incorrect
    v_Message := MyLibrary_.UserStrings.getString(v_code);
  end
  else
  begin
    v_code := 'ML00003'; // Something went wrong
    v_Message := MyLibrary_.UserStrings.getString(v_code);
  end;
  //
  raise EMyLibrary_Connection.create(v_CODE, v_Message, v_AditionalInfo);
end;

function TMyLibrary_ProxyRestClient.ProxiedPost(const aResource, aBody, aContentType: string): IMVCRESTResponse;
begin
  try
    result := fRestClient.Post(aResource, aBody, aContentType);
    if not Result.Success then
      manageConnectionResponseNotSuccess_and_Raise(aResource, result);
  except
    on E: Exception do
    begin
      manageConnectionException_and_Raise(aResource, e);
      changeToNextServer;
      raise;
    end;
  end;
end;

{ EMyLibrary_Connection }

constructor EMyLibrary_Connection.create(const p_CODE, p_Message, p_AditionalInfo: string);
begin
  inherited create('('+p_code+') ' + p_message + '... ' + sLineBreak + sLineBreak + p_AditionalInfo);
end;

end.
