unit MyLibrary.StringUtil;

interface

uses System.SysUtils, Winapi.Windows, System.Classes;


type
  TMyLibraryStringUtil = Class(TObject)
  private
    // ------
  protected
  public
    class function getLineStatedByREGEX(const p_regex: string; p_tmpTextMessage: TStringList; p_initial_line: Integer): Integer;
    class procedure trimSpacesOnEachLINE(p_strings: TStringList); overload;
    class procedure trimSpacesOnEachLINE(var p_strings: string); overload;
    class procedure trimBlankLinesAboveBelow(p_strings: TStringList);
End;


implementation

uses
  System.RegularExpressions;


// -----------------------------------------------------------------------------
// Search line started by "p_regex", return line number
class function TMyLibraryStringUtil.getLineStatedByREGEX(const p_regex: string; p_tmpTextMessage: TStringList; p_initial_line: Integer): Integer;
var
  i: integer;
begin
  result := -1;
  for i := p_initial_line to p_tmpTextMessage.Count - 1 do
    if TRegEx.IsMatch(p_tmpTextMessage.Strings[i], p_regex) then
    begin
      result := i;
      break;
    end;
end;

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