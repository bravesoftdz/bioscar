unit uMaletas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ComCtrls, Grids, DBGrids, DBCtrls, Buttons,
  ExtCtrls, Mask;

type
  TformMaletas = class(TForm)
    grdLog: TDBGrid;
    dtFecha: TDateTimePicker;
    Label1: TLabel;
    btnCerrar: TBitBtn;
    Label2: TLabel;
    DBNavigator1: TDBNavigator;
    edtQad: TDBEdit;
    btnPreview: TBitBtn;
    btnPrint: TBitBtn;
    procedure dsLogStateChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure dtFechaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMaletas: TformMaletas;

implementation
uses {QuickRpt, QRExport,} uDM{, rMaletas};
{$R *.dfm}

procedure TformMaletas.btnPrintClick(Sender: TObject);
begin
  //frmRMaletas.rptMaletas.Print;
end;

procedure TformMaletas.dsLogStateChange(Sender: TObject);
begin
  if dm.dsPayrolls.State = dsInsert then
    dm.dsPayrolls.DataSet.Cancel;
end;

procedure TformMaletas.dtFechaExit(Sender: TObject);
begin
  with dm do
  begin
    newPayroll.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    newPayroll.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    try
      newPayroll.Execute;
    except
      ShowMessage('Se produjo un error tratando de generar Asistencias');
    end;
  end;

  dm.qDepts.Close;
  dm.qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Open;
  dm.qDepts.First;
  grdLog.Refresh;
end;

procedure TformMaletas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=27 then
    Close;
end;

procedure TformMaletas.FormActivate(Sender: TObject);
begin
  dtFecha.Date:=Date;
  with dm do
  begin
    newPayroll.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    newPayroll.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    try
      newPayroll.Execute;
    except
      ShowMessage('Se produjo un error tratando de generar Asistencias');
    end;
  end;
  {End Update}
  dm.qDepts.Close;
  dm.qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Open;
  dm.qDepts.First;
  dm.dsPayrolls.DataSet.Open;
end;

procedure TformMaletas.btnPreviewClick(Sender: TObject);
begin
  //frmRMaletas.rptMaletas.Preview;
end;

end.
