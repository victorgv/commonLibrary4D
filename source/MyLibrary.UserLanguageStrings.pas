{String resource for a multi-language app solution.
 I use it for store all string text (messages, dinamic labels, etc)
 YES, I know... it's not the best solution but is one and easy... later I'll review other options}

unit MyLibrary.UserLanguageStrings;

interface

uses System.Classes,
     System.Generics.Collections;

type
   TMyLibrary_UserLanguageStrings_Types = (lgEnglish, lgSpanish);

type
  TMyLibrary_String = class
    private
      fAdditional_info: string;
      fCode: string;
      fString_: string;
    public
      property code: string read fCode;
      property string_: string read fString_;
      property additional_info: string read fAdditional_info;

      constructor create(const p_Code, p_String_, p_Additional_info: string);
  end;

type
  TMyLibrary_UserLanguageStrings = class
    private
      fDictionary: TDictionary<String, TMyLibrary_String>;
      procedure AddItemToDictionary(const p_Code, p_String_, p_Additional_info: string);
    public
      constructor create(p_language: TMyLibrary_UserLanguageStrings_Types);
      destructor destroy;
      procedure setLanguage(p_language: TMyLibrary_UserLanguageStrings_Types);
      function getString(const p_code: string): string;
    end;

implementation

{ TMyLibrary_UserLanguageStrings }

procedure TMyLibrary_UserLanguageStrings.AddItemToDictionary(const p_Code, p_String_, p_Additional_info: string);
begin
  fDictionary.Add(p_Code, TMyLibrary_String.create(p_code, p_string_, p_additional_info));
end;

constructor TMyLibrary_UserLanguageStrings.create(p_language: TMyLibrary_UserLanguageStrings_Types);
begin
  inherited create;
  fDictionary := TDictionary<String, TMyLibrary_String>.Create;
  setLanguage(p_language);
end;

destructor TMyLibrary_UserLanguageStrings.destroy;
begin
  fDictionary.Free;
  inherited;
end;

function TMyLibrary_UserLanguageStrings.getString(const p_code: string): string;
begin
  result := fDictionary.Items[p_code].string_;
end;

procedure TMyLibrary_UserLanguageStrings.setLanguage(p_language: TMyLibrary_UserLanguageStrings_Types);
begin
  if p_language = lgEnglish then
  begin
    AddItemToDictionary('ML00001','Login successful','');
    AddItemToDictionary('ML00002','User or password incorrect','');
    AddItemToDictionary('ML00003','Something went wrong','');
    AddItemToDictionary('ML00004','Username required','');
    AddItemToDictionary('ML00005','Password required','');
  end;


end;

{ TMyLibrary_String }

constructor TMyLibrary_String.create(const p_Code, p_String_, p_Additional_info: string);
begin
  inherited create;
  fCode := p_Code;
  fString_ := p_String_;
  fAdditional_info := p_Additional_info;
end;

end.
