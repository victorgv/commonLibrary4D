unit MyLibrary.StringUtil;

interface

uses System.SysUtils, Winapi.Windows, System.Classes;


type
  TMyLibraryStringUtil = Class(TObject)
  private
    // ------
  protected
  public
    class procedure trimSpacesOnEachLINE(p_strings: TStringList); overload;
    class procedure trimSpacesOnEachLINE(var p_strings: string); overload;
End;


implementation


// -----------------------------------------------------------------------------

class procedure TMyLibraryStringUtil.trimSpacesOnEachLINE(var p_strings: string);
var
  vStringList: TStringList;
begin
  vStringList := TStringList.Create;
  try
    vStringList.Text := p_strings;
    trimSpacesOnEachLINE(vStringList);
    p_strings := vStringList.Text;
  finally
    vStringList.Free;
  end;
end;

// -----------------------------------------------------------------------------

class procedure TMyLibraryStringUtil.trimSpacesOnEachLINE(p_strings: TStringList);
var
  i: Integer;
begin
  for i := 0 to p_strings.Count - 1 do
    p_strings.Strings[i] := (p_strings.Strings[i]).Trim;
end;

// -----------------------------------------------------------------------------

end.