{String resource for a multi-language app solution.
 I use it for store all string text (messages, dinamic labels, etc)
 YES, I know... it's not the best solution but is one and easy... later I'll review other options}

unit MyLibrary.UserLanguageStrings;

interface

uses System.Classes;

type
   TMyLibrary_UserLanguageStrings_Types = (lgEnglish, lgSpanish);

type
  TMyLibrary_UserLanguageStrings = class(TStringList)
    private
    public
      constructor create(p_language: TMyLibrary_UserLanguageStrings_Types);
      procedure setLanguage(p_language: TMyLibrary_UserLanguageStrings_Types);
      function getString(const p_code: string): string;
    end;

implementation

{ TMyLibrary_UserLanguageStrings }

constructor TMyLibrary_UserLanguageStrings.create(p_language: TMyLibrary_UserLanguageStrings_Types);
begin
  inherited create;
  setLanguage(p_language);
end;

function TMyLibrary_UserLanguageStrings.getString(const p_code: string): string;
begin
  result := Values[p_code];
end;

procedure TMyLibrary_UserLanguageStrings.setLanguage(p_language: TMyLibrary_UserLanguageStrings_Types);
begin
  if p_language = lgEnglish then
  begin
    AddPair('ML00001','Login successful');
    AddPair('ML00002','User or password incorrect');
    AddPair('ML00003','Something went wrong');
  end;


end;

end.
