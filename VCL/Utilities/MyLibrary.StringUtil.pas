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
    class procedure trimBlankLinesAboveBelow(p_strings: TStringList);
End;


implementation


// -----------------------------------------------------------------------------

class procedure TMyLibraryStringUtil.trimBlankLinesAboveBelow(p_strings: TStringList);
begin
  if p_strings.Count > 0 then
  begin
    // Delete Above
    while p_strings.Strings[0].Trim = '' do
      p_strings.Delete(0);

    // Delete below
    while p_strings.Strings[p_strings.Count-1].Trim = '' do
      p_strings.Delete(p_strings.Count-1);
  end;
end;

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