unit uPersonal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, Buttons,
  ComCtrls, DBActns, ActnList;

type
  TformPersonal = class(TForm)
    GroupBox1: TGroupBox;
    btnAceptar: TButton;
    btnCancelar: TButton;
    pnlBrowse: TPanel;
    dbgEmp: TDBGrid;
    edtSearch: TEdit;
    BitBtn1: TBitBtn;
    pgcPersonal: TPageControl;
    tbsBus: TTabSheet;
    tbsABM: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    grpDatos: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edtApe: TDBEdit;
    edtNom: TDBEdit;
    chkHabilitado: TDBCheckBox;
    edtFecha: TDBEdit;
    edtQad: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    Label4: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnBuscar: TBitBtn;
    edtId: TDBEdit;
    Button1: TButton;
    ActionList1: TActionList;
    dtsFirst: TDataSetFirst;
    dtsPrior: TDataSetPrior;
    dtsNext: TDataSetNext;
    dtsLast: TDataSetLast;
    dtsIns: TDataSetInsert;
    dtsDel: TDataSetDelete;
    dtsEdt: TDataSetEdit;
    dtsPos: TDataSetPost;
    dtsCan: TDataSetCancel;
    dtsRfr: TDataSetRefresh;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id: Double;
  end;

var
  formPersonal: TformPersonal;

implementation

uses uDM;
{$R *.dfm}

procedure TformPersonal.BitBtn2Click(Sender: TObject);
begin
  pgcPersonal.ActivePage:=tbsABM;
  dm.dsEmp.DataSet.Open;
  dm.dsEmp.Enabled:=true;
  dm.dsEmp.DataSet.Insert;
end;

procedure TformPersonal.btnAceptarClick(Sender: TObject);
begin
  if length(edtApe.Text)<2 then
    edtApe.SetFocus
  else if length(edtNom.Text)<2 then
    edtNom.SetFocus
  else
    begin
    formPersonal.id:=StrToFloat(edtID.Text);
    dm.Employees.Post;
    dm.Employees.Close;
    edtID.Text:='';
    ModalResult:=mrOk;
    end;
end;

procedure TformPersonal.edtSearchChange(Sender: TObject);
begin
  dm.Employees.DisableControls;
  dm.Employees.Filter:='lastname like '''+edtSearch.Text+'%''';
  if edtSearch.Text<>'' then dm.Employees.Filtered:=true;
  dbgEmp.Refresh;
  dm.Employees.EnableControls;
end;

procedure TformPersonal.FormDeactivate(Sender: TObject);
begin
  dm.Employees.Cancel;
  edtID.Text:='';
  grpDatos.Enabled:=false;
  btnAceptar.Caption:='Aceptar';
 end;

procedure TformPersonal.btnCancelarClick(Sender: TObject);
begin
  dm.Employees.Cancel;
  dm.Employees.Close;
  edtID.Text:='';
  grpDatos.Enabled:=false;
  btnAceptar.Caption:='Aceptar';
end;

procedure TformPersonal.FormActivate(Sender: TObject);
begin
  dm.Employees.Cancel;
  dm.Employees.Open;
  dm.Employees.First;
  edtID.Text:='';
  //grpDatos.Enabled:=false;
  //btnAceptar.Caption:='Aceptar';
  dm.qEmployees.Open;
  dm.dsEmp.Enabled:=true;
  //edtID.SetFocus;
end;

procedure TformPersonal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
  SelectNext(ActiveControl, true, true);
end;

end.
