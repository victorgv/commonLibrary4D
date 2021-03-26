unit MyLibrary.FormUtil;

interface

uses System.SysUtils,  System.Classes,
     FMX.Forms, FMX.TabControl, System.UITypes;



type
  TMyLibraryFormBase = Class(TForm)
  private
    // ------
  protected
  public
End;

type TClassOfForm = class of TMyLibraryFormBase;

Type
  TMyLibraryTabsArrayRecord = array of record
    TabItem: TTabItem;
    TabForm: TForm;
    ActiveFormTabByClass: TClass;
    IsbtnMenuVisible: Boolean;
    IsbtnBackVisible: Boolean;
    MenuButtonsColor: TAlphaColor;
  end;

type
  TMyLibraryFormBase_MDI_Tabbed = Class(TMyLibraryFormBase)
  private
    FTabsArray: TMyLibraryTabsArrayRecord;
    //
    function checkFormIsAlreadyOpen(p_formClass: TClassOfForm): integer;
  protected
    function getTabControl: TTabControl; virtual; abstract;
  public
    property TabsArray: TMyLibraryTabsArrayRecord read FTabsArray;
    procedure CallForm(p_formClass: TClassOfForm; p_swiCanRepeat: boolean = FALSE);
  end;


implementation


{ TMyLibraryFormBase_MDI_Tabbed }

uses uFmxUsers, uFmxMain;

// Check if form already exist if then return the index of position on de TabsArray, if not returns -1
function TMyLibraryFormBase_MDI_Tabbed.checkFormIsAlreadyOpen(p_formClass: TClassOfForm): integer;
begin

  // TO-DO
  result := -1;

end;


procedure TMyLibraryFormBase_MDI_Tabbed.CallForm(p_formClass: TClassOfForm; p_swiCanRepeat: boolean);
var
  i: integer;
begin
  if p_swiCanRepeat then i := -1
  else i := checkFormIsAlreadyOpen(p_formClass);

  if i = -1 then
  begin
    i := Length(FTabsArray) + 1;
    SetLength(FTabsArray, i);
    //FTabControl.Add()
    TabsArray[i].TabItem:= TTabItem.Create(getTabControl); //getTabControl.add;
    TabsArray[i].TabItem.Parent:= getTabControl;
    //TabsArray[i].TabItem.TabControl := getTabControl;
    getTabControl.ActiveTab := TabsArray[i].TabItem;
    TabsArray[i].TabItem.AutoSize:= False;
    TabsArray[i].TabForm:= p_formClass.Create(TabsArray[Length(TabsArray) - 1].TabItem);
    //TfmxUsers(TabsArray[i].TabForm).Layout1.Parent := TabsArray[i].TabItem;
    TfmxUsers(TabsArray[i].TabForm).Parent := TabsArray[i].TabItem;
    //TabsArray[i].TabForm.Show;
  end;

end;

end.