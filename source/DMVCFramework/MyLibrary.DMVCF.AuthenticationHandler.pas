unit MyLibrary.DMVCF.AuthenticationHandler;

interface

uses MVCFramework, System.Generics.Collections;

type
  TMyLibrary_AuthenticationHandler = class(TInterfacedObject, IMVCAuthenticationHandler)
  public
    // called at each request to know if the request requires an authentication
    procedure OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName: string; const ActionName: string; var AuthenticationRequired: Boolean);

    // if authentication is required, this method must execute the user authentication
    procedure OnAuthentication(const AContext: TWebContext; const UserName: string; const Password: string; UserRoles: TList<System.string>;
                               var IsValid: Boolean; const SessionData: System.Generics.Collections.TDictionary<System.string, System.string>);

    // if authenticated, this method defines the user roles
    procedure OnAuthorization(const AContext: TWebContext; UserRoles: System.Generics.Collections.TList<System.string>; const ControllerQualifiedClassName: string;
                              const ActionName: string; var IsAuthorized: Boolean);

  end;



implementation

{ TCustomAuth }

procedure TMyLibrary_AuthenticationHandler.OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName, ActionName: string; var AuthenticationRequired: Boolean);
begin
  // Only public controllers won't need to be authenticated
  AuthenticationRequired := ControllerQualifiedClassName = 'MyLibrary.DMVCF.Controller.Public_V01.TMyLibrary_DMVCF_Controller_Public';

  // Also it can be used on private controllers only in specific Actions, p.e.:
  {if AuthenticationRequired then
  begin
    if ActionName = 'PublicAction' then
    begin
      AuthenticationRequired := False;
    end;
  end;}
end;

procedure TMyLibrary_AuthenticationHandler.OnAuthentication(const AContext: TWebContext; const UserName, Password: string; UserRoles: TList<System.string>; var IsValid: Boolean;
                                                            const SessionData: System.Generics.Collections.TDictionary<System.string, System.string>);
begin
  IsValid := Password = ('pwd' + UserName);
  if IsValid then
   begin
     UserRoles.Add('role1');
     UserRoles.Add('role2');
   end;
   IsValid := UserRoles.Count > 0;
end;

procedure TMyLibrary_AuthenticationHandler.OnAuthorization(const AContext: TWebContext; UserRoles: System.Generics.Collections.TList<System.string>;
                                                           const ControllerQualifiedClassName, ActionName: string; var IsAuthorized: Boolean);
begin
{  if ControllerQualifiedClassName = 'PrivateControllerU.TPrivateController' then
  begin
    IsAuthorized := UserRoles.Contains('admin');
    if not IsAuthorized then
      IsAuthorized := (UserRoles.Contains('role1')) and (ActionName = 'OnlyRole1');
    if not IsAuthorized then
      IsAuthorized := (UserRoles.Contains('role2')) and (ActionName = 'OnlyRole2');
  end
  else
  begin
    // You can always navigate in the public section of API
    IsAuthorized := True;
  end;}

end;


end.
