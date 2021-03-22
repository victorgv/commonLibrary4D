unit MyLibrary.General;

interface

uses System.SysUtils, Winapi.Windows, System.Classes;

type
  TMyLibraryGeneral = Class(TObject)
  private
    // ------
  protected
  public
    class function getFileEXEorDLLVersion(const p_file: string): string; overload;
    class function getFileEXEorDLLVersion: string; overload;
    // ---------
    constructor Create; virtual;
    destructor Destroy; override;
End;

implementation

// -----------------------------------------------------------------------------

constructor TMyLibraryGeneral.Create;
begin
  inherited create;
end;

// -----------------------------------------------------------------------------

destructor TMyLibraryGeneral.Destroy;
begin
  inherited;
end;

// -----------------------------------------------------------------------------

class function TMyLibraryGeneral.getFileEXEorDLLVersion: string;
begin
  result := getFileEXEorDLLVersion(ParamStr(0));
end;

// -----------------------------------------------------------------------------

class function TMyLibraryGeneral.getFileEXEorDLLVersion(const p_file: string): string;
var
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Size := GetFileVersionInfoSize(PChar(p_file), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(p_file), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d build %d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     //LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]) //build
end;


// -----------------------------------------------------------------------------

end.