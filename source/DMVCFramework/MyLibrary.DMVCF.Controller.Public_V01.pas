unit MyLibrary.DMVCF.Controller.Public_V01;

interface

uses
  MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons;

type

  [MVCPath('/api/public_v01')]
  TMyLibrary_DMVCF_Controller_Public = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/ping')]
    [MVCHTTPMethod([httpGET])]
    procedure Ping;


    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);

    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(id: Integer);

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer(id: Integer);

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: Integer);

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils;

procedure TMyLibrary_DMVCF_Controller_Public.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TMyLibrary_DMVCF_Controller_Public.Ping;
begin
  Render('Pong');
end;

procedure TMyLibrary_DMVCF_Controller_Public.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TMyLibrary_DMVCF_Controller_Public.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TMyLibrary_DMVCF_Controller_Public.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;



//Sample CRUD Actions for a "Customer" entity
procedure TMyLibrary_DMVCF_Controller_Public.GetCustomers;
begin
  //todo: render a list of customers
end;

procedure TMyLibrary_DMVCF_Controller_Public.GetCustomer(id: Integer);
begin
  //todo: render the customer by id
end;

procedure TMyLibrary_DMVCF_Controller_Public.CreateCustomer;

begin
  //todo: create a new customer
end;

procedure TMyLibrary_DMVCF_Controller_Public.UpdateCustomer(id: Integer);
begin
  //todo: update customer by id
end;

procedure TMyLibrary_DMVCF_Controller_Public.DeleteCustomer(id: Integer);
begin
  //todo: delete customer by id
end;



end.
