unit uTServiceImplementationSUPER;

interface

uses Vcl.SvcMgr, Vcl.Forms, Winapi.Windows,System.SysUtils,System.Classes;

type
  TLogMessageProcedure = procedure(const p_Message: String) of object;

type TServiceImplementationSUPER = Class(TThread)
  private
    fLogMessage: TLogMessageProcedure;
    _ACTIVO: boolean;
    _Service: TService;
    // ------

  protected
    procedure sendEventToLogMessage(const p_message: String; p_EventType: DWord); // Send to Event Viewer
    procedure validateInstanceIsLive; Virtual; Abstract;  // Check our Thread/Threads/Action/Actions, etc... are living
    function getServiceCode: String; Virtual; Abstract;  // Unique code to indentify your service
    procedure Initializations; virtual;
  public
    property Activo: Boolean read _activo;
    property serviceCode: String read getServiceCode;
    // ------
    procedure ProcesarMensajes;
    function TestApplicationTerminated: boolean; // Devuelve TRUE si el programa se esta finalizando
    procedure ServiceExecute; virtual;
    procedure ServiceStop; virtual;
    //
    procedure Execute; override;
    // ------
    constructor Create(p_LogMessage: TLogMessageProcedure); overload; virtual;
    constructor Create(p_Service: TService); overload; virtual;
    destructor Destroy; override;
End;

implementation

// -----------------------------------------------------------------------------

constructor TServiceImplementationSUPER.Create(p_Service: TService);
begin
  inherited create(TRUE);
  // (1) Incializaciones clase
  _ACTIVO := FALSE;
  _Service := p_Service;

  sendEventToLogMessage('ServiceCreate: OK', EVENTLOG_INFORMATION_TYPE);

end;

// -----------------------------------------------------------------------------

constructor TServiceImplementationSUPER.Create(p_LogMessage: TLogMessageProcedure);
begin
  _Service := NIL;
  fLogMessage := p_LogMessage;
  create(_Service);
end;



// -----------------------------------------------------------------------------

procedure TServiceImplementationSUPER.ServiceExecute;
begin
  Start;
end;

// -----------------------------------------------------------------------------

procedure TServiceImplementationSUPER.ServiceStop;
begin
  Terminate;
end;


// -----------------------------------------------------------------------------
// Procesa mensajes pendientes. Combinar con sleep().
procedure TServiceImplementationSUPER.ProcesarMensajes;
begin
  if assigned(_service) then
  begin
    if Assigned(_service.ServiceThread) then
      _service.ServiceThread.ProcessRequests(false);
  end
  else
    Application.ProcessMessages;
end;

// ------------------------------------------------------------------------------

procedure TServiceImplementationSUPER.sendEventToLogMessage(const p_message: String; p_EventType: DWord);
var
  v_type: String;
begin
  if assigned(_Service) then _Service.LogMessage(p_message,p_EventType) // Log de eventos de windows
  else if assigned(fLogMessage) then
  begin
    case p_EventType of
      EVENTLOG_INFORMATION_TYPE: v_type := 'INFO';
      EVENTLOG_ERROR_TYPE: v_type := 'ERROR';
    else
      v_type := 'OTHER';
    end;
    Queue(nil, procedure
      begin
        fLogMessage(v_type+'> '+p_message);
      end);
  end
  else ;
end;

// -----------------------------------------------------------------------------

destructor TServiceImplementationSUPER.Destroy;
var
  i: integer;
begin
  _ACTIVO := FALSE;
  // Damos 5 segundos para terminar procesos etc.
  for i:=0 to 10 do
  begin
    ProcesarMensajes;
    sleep(500);
  end;

  // Finalmente morimos...
  inherited;
end;

// -----------------------------------------------------------------------------

function TServiceImplementationSUPER.TestApplicationTerminated: boolean;
begin
  // (1) Si estamos ejecutando servicio evaluamos el terminated del servicio
  if Assigned(_Service) then  result := _Service.Terminated
  // (2) otro caso la ejecuci�n es un programa normal por lo que evaliamos el application
  else result := Application.Terminated;
end;


// -----------------------------------------------------------------------------

procedure TServiceImplementationSUPER.Execute;
begin
  //
  while not Terminated AND (NOT TestApplicationTerminated) do  // Evalua cuando tiene que finalizar
  try
    validateInstanceIsLive;
    Sleep(1000);
    sendEventToLogMessage('HOLA',EVENTLOG_INFORMATION_TYPE);
    ProcesarMensajes;
  except
    on e: exception do
    begin // Captura las excepciones, ya que sino el servicio muere.
      sleep(5000);
      // LOG.escribeERROR(e.Message);
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TServiceImplementationSUPER.Initializations;
begin

end;

// -----------------------------------------------------------------------------


end.
