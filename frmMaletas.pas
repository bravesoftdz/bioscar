unit frmMaletas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, DBClient, Provider;

type
  TfMaletas = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    dspPayroll: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMaletas: TfMaletas;

implementation

uses udm;
{$R *.dfm}

procedure TfMaletas.Button1Click(Sender: TObject);
begin
  dm.adoCnx.Connected:=true;
  dm.tPayrolls.Open;
  ClientdataSet1.Open;
  
end;

procedure TfMaletas.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  SysUtils.Abort;
end;

end.
