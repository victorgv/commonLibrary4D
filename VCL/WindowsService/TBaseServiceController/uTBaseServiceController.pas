unit uTBaseServiceController;

interface

uses Vcl.SvcMgr, Vcl.Forms, Winapi.Windows,System.SysUtils ;

type TBaseServiceController = Class
  private
    _ACTIVO: boolean;
    _Service: TService;
    // ------
  protected
  public
    property Activo: Boolean read _activo;
    // ------
    procedure PararThreads_;
    procedure ActivarThreads;
    procedure ProcesarMensajes;
    function EvaluaTerminated: boolean; // Devuelve TRUE si el programa se esta finalizando
    procedure ServiceExecute; virtual;
    procedure ServiceStop; virtual;
    // ------
    constructor Create(p_Service: TService); virtual;
    destructor Destroy; override;
End;

implementation

// -----------------------------------------------------------------------------

constructor TBaseServiceController.Create(p_Service: TService);
begin
  inherited create;
  // (1) Incializaciones clase
  _ACTIVO := FALSE;
  _Service := p_Service;
end;

// --------------------------------------------------------------------------------------

procedure TBaseServiceController.ActivarThreads;
begin
  _ACTIVO := TRUE;
end;

// --------------------------------------------------------------------------------------

procedure TBaseServiceController.PararThreads_;
begin
  _ACTIVO := FALSE;
end;

// -----------------------------------------------------------------------------

procedure TBaseServiceController.ServiceExecute;
begin
  ActivarThreads;
  //
  while (Activo) AND (NOT EvaluaTerminated) do  // Evalua cuando tiene que finalizar
  try
    Sleep(1000);
    ProcesarMensajes;
    if Activo then // Si después del sleep sigue activo
    begin
      //_chequea_instancias_activas;
    end;
  except
    on e: exception do
    begin // Captura las excepciones, ya que sino el servicio muere.
      sleep(15000);
      // LOG.escribeERROR(e.Message);
    end;
  end;
  PararThreads_;
end;

// -----------------------------------------------------------------------------

procedure TBaseServiceController.ServiceStop;
begin
  inherited;
  PararThreads_;
end;


// -----------------------------------------------------------------------------
// Procesa mensajes pendientes. Combinar con sleep().
procedure TBaseServiceController.ProcesarMensajes;
begin
  if assigned(_service) then
  begin
    if Assigned(_service.ServiceThread) then
      _service.ServiceThread.ProcessRequests(false);
  end
  else
    Application.ProcessMessages;
end;

// -----------------------------------------------------------------------------

destructor TBaseServiceController.Destroy;
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

function TBaseServiceController.EvaluaTerminated: boolean;
begin
  // (1) Si estamos ejecutando servicio evaluamos el terminated del servicio
  if Assigned(_Service) then  result := _Service.Terminated
  // (2) otro caso la ejecución es un programa normal por lo que evaliamos el application
  else result := Application.Terminated;
end;

// -----------------------------------------------------------------------------


end.
