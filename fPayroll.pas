unit fPayroll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Mask, ComCtrls, Buttons, DB, ADODB, Grids, DBGrids,
  rxToolEdit, RXDBCtrl;

type
  TfrmPayroll = class(TForm)
    dtpDate: TDateTimePicker;
    DBGrid1: TDBGrid;
    dtsPayroll: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    btnPrint: TBitBtn;
    BitBtn1: TBitBtn;
    btnCerrar: TBitBtn;
    tblPayrollD: TADOTable;
    DBEdit1: TDBEdit;
    dtsPayrollD: TDataSource;
    dbnPayroll: TDBNavigator;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    newPayroll: TADODataSet;
    tblPayrollDperiod: TDateTimeField;
    tblPayrollDgname: TWideStringField;
    tblPayrollDprice: TBCDField;
    btnGetPay: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure dtpDateExit(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dbnPayrollClick(Sender: TObject; Button: TNavigateBtn);
    procedure tblPayrollDBeforeDelete(DataSet: TDataSet);
    procedure tblPayrollDBeforeInsert(DataSet: TDataSet);
    procedure btnGetPayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lstGroups: TStringList;
  end;

var
  frmPayroll: TfrmPayroll;

implementation

uses uDM, {uPlanilla1, uPlanilla,} DateUtils;

{$R *.dfm}

procedure TfrmPayroll.BitBtn1Click(Sender: TObject);
begin
  {formPlanilla1.adoBag.Close;
  formPlanilla1.adoBag.Parameters.ParamByName('fecha').Value:=DateToStr(dtpDate.Date);
  formPlanilla1.adoBag.Open;
  formPlanilla1.rptMaletas.Preview;}
end;

procedure TfrmPayroll.btnGetPayClick(Sender: TObject);
begin
  if dm.PayrollExist(dtpDate.Date) then
  begin
    //dm.PayrollUpdate(dtpDate.Date);
    tblPayrollD.Filter:='period='+dateTostr(dtpDate.Date);
    tblPayrollD.Open;
    dbnPayrollClick(self,nbFirst);
  end
  else
    if MessageDlg('No existe planilla para este dia. Desea crearla?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      dm.PayrollCreate(dtpDate.Date);
      tblPayrollD.Filter:='period='+dateTostr(dtpDate.Date);
      tblPayrollD.Open;
      dbnPayrollClick(self,nbFirst);
    end;

end;

procedure TfrmPayroll.btnPrintClick(Sender: TObject);
begin
 { formPlanilla.adoCon.Close;
  formPlanilla.adoCon.Parameters.ParamByName('fecha').Value:=DateToStr(dtpDate.Date);
  formPlanilla.adoCon.Open;
  formPlanilla.rptMaletas.Preview;}
end;

procedure TfrmPayroll.dbnPayrollClick(Sender: TObject; Button: TNavigateBtn);
begin
  newPayroll.Close;
  case button of
    nbFirst,
    nbPrior,
    nbNext,
    nbLast:
      begin
        newPayroll.Parameters.ParamByName('period').DataType:=ftDate;
        newPayroll.Parameters.ParamByName('period').Value:=encodedate(YearOf(tblPayrollDPeriod.Value),MonthOf(tblPayrollDPeriod.Value),DayOf(tblPayrollDPeriod.Value));
        newPayroll.Parameters.ParamByName('gname').Value:=tblPayrollDGName.Value;
      end;
  end;
  newPayroll.Prepared:=true;
  newPayroll.Active:=true;
end;

procedure TfrmPayroll.dtpDateExit(Sender: TObject);
begin
{
  Si no existe Payroll entonces Crear Payroll y Detail
  Si existe Payroll entonces
    Actualizar Payroll
    Actualizar Detail
}
end;

procedure TfrmPayroll.FormCreate(Sender: TObject);
begin
  lstGroups:=TStringList.Create;
end;

procedure TfrmPayroll.tblPayrollDBeforeDelete(DataSet: TDataSet);
begin
  SysUtils.Abort;
end;

procedure TfrmPayroll.tblPayrollDBeforeInsert(DataSet: TDataSet);
begin
  SysUtils.Abort;
end;

end.
