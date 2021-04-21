unit MyLibrary.Session;

interface

type
  TMyLibrary_Session = Class
  private
    fUsername: string;
    fFWT_Token: string;
  public
    property Username: string read fUsername;
    property FWT_Token: string read fFWT_Token;
    //
    constructor create(const p_JWT_Token: string);

  End;

implementation

{ TMyLibrary_Session }

constructor TMyLibrary_Session.create(const p_JWT_Token: string);
begin
  inherited create;
  fFWT_Token := p_JWT_Token;
end;

end.
