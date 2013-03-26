unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient, Provider, Controls;

type
  Tdm = class(TDataModule)
    adoCnx: TADOConnection;
    adoCon: TADOQuery;
    adoBag: TADOQuery;
    adoBagApeNom: TStringField;
    adoBagcuadrillaid: TIntegerField;
    adoBagid: TFloatField;
    adoBagmaleta01: TIntegerField;
    adoBagmaleta02: TIntegerField;
    dsCon: TDataSource;
    adoPer: TADOQuery;
    adoQad: TADOQuery;
    adoQadid: TAutoIncField;
    adoQadcontratistaid: TIntegerField;
    adoQadcuadrilla: TWideStringField;
    adoLog1: TADOTable;
    adoLog1fechahora: TDateTimeField;
    adoLog1ID: TFloatField;
    adoLog1apenom: TStringField;
    adoLog1ContratistaID: TIntegerField;
    adoLog1CuadrillaID: TIntegerField;
    adoLog1Maleta01: TIntegerField;
    adoLog1Maleta02: TIntegerField;
    adoLog1fecha: TDateTimeField;
    adoPer1: TADOTable;
    dsLog: TDataSource;
    qryLogin: TADOQuery;
    tblUsers: TADOTable;
    adoPer1ApeNom: TStringField;
    adoPer1apellido: TWideStringField;
    adoPer1nombre: TWideStringField;
    qryPersonas: TADOQuery;
    qryHabilitados: TADOQuery;
    qryHits: TADOQuery;
    adoPer1ID: TFloatField;
    adoPer1template: TBlobField;
    adoPer1fecha: TDateTimeField;
    adoPer1habilitado: TWordField;
    adoPer1contratistaid: TIntegerField;
    adoPer1cuadrillaid: TIntegerField;
    adoPer1hits: TIntegerField;
    qryManual: TADOQuery;
    tblUsersUsername: TWideStringField;
    tblUsersPassword: TWideStringField;
    tblUsersUserType: TIntegerField;
    qryPerGral: TADOQuery;
    qryImport: TADOQuery;
    dsImport: TDataSource;
    qryAsis: TADOQuery;
    qryQuad: TADOQuery;
    dsQuad: TDataSource;
    tblJrn: TADOTable;
    dsJrn: TDataSource;
    qryQad: TADOQuery;
    dsQad: TDataSource;
    tblJrnmaleta0: TIntegerField;
    tblJrnmaleta1: TIntegerField;
    tblJrnjornal: TIntegerField;
    qryGralPer: TADOQuery;
    tblJrnfecha: TDateTimeField;
    tblJrngrupo: TIntegerField;
    tblJrnid: TFloatField;
    tblJrnapenom: TStringField;
    qryJrn: TADOQuery;
    dtsJrn: TADODataSet;
    cmdJrn: TADOCommand;
    qryJrnEx: TADOQuery;
    qryAsisToday: TADOQuery;
    Employees: TADOTable;
    Entries: TADOQuery;
    dsEntries: TDataSource;
    newEntry: TADOCommand;
    qDepts: TADOQuery;
    dsDepts: TDataSource;
    qPayrolls: TADOQuery;
    dsPayrolls: TDataSource;
    newPayroll: TADOCommand;
    dsEmployees: TDataSource;
    qEmployees: TADOQuery;
    qEnableEmp: TADOQuery;
    dsEmp: TDataSource;
    Departments: TADOTable;
    dsDepartments: TDataSource;
    cmdXport: TADODataSet;
    cmdImport: TADODataSet;
    cmdAux: TADODataSet;
    BioFingers: TADOTable;
    Payrolls: TADOTable;
    Entries1: TADOTable;
    tPayrolls: TADOTable;
    dsPayroll: TDataSource;
    qryScar: TADOQuery;
    dsEmpGrid: TDataSource;
    procedure adoLog1CalcFields(DataSet: TDataSet);
    procedure adoPer1CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dsJrnStateChange(Sender: TObject);
    procedure DepartmentsBeforePost(DataSet: TDataSet);
    procedure EmployeesBeforePost(DataSet: TDataSet);
    procedure tblUsersBeforePost(DataSet: TDataSet);
    procedure qEmployeesAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    ScarDBPath: string;
  public
    { Public declarations }
    function PayrollExist(ADate: TDate): boolean;
    procedure PayrollCreate(ADate: TDate);
    procedure PayrollDCreate(ADate: TDate);
    const
      ScarDBName = {$IFNDEF DEBUG}'Scar.mdb'{$ELSE} 'Scar0.mdb' {$ENDIF};
  end;

var
  dm: Tdm;

implementation

uses DateUtils;

{$R *.dfm}

procedure Tdm.PayrollDCreate(ADate: TDate);
begin
  qryScar.Close;
  qryScar.SQL.Clear;
  qryScar.SQL.Add('INSERT INTO payrolld ( period, gname )');
  qryScar.SQL.Add('SELECT payroll.period, payroll.gname');
  qryScar.SQL.Add('FROM payroll');
  qryScar.SQL.Add('WHERE payroll.period=:period');
  qryScar.SQL.Add('GROUP BY payroll.period, payroll.gname');
  qryScar.Parameters.ParamByName('period').DataType:=ftDate;
  qryScar.Parameters.ParamByName('period').Value:=encodedate(YearOf(ADate),MonthOf(Adate),DayOf(ADate));
  qryScar.Prepared:=true;
  try
    qryScar.ExecSQL;
  finally
    qryScar.Close;
  end;
end;


procedure Tdm.PayrollCreate(ADate: TDate);
begin
  qryScar.Close;
  qryScar.SQL.Clear;
  qryScar.SQL.Add('INSERT INTO payroll ( period, gname, empid )');
  qryScar.SQL.Add('SELECT asistencias.fecha, cuadrillas.Cuadrilla, asistencias.ID');
  qryScar.SQL.Add('FROM asistencias INNER JOIN cuadrillas ON asistencias.CuadrillaID = cuadrillas.ID');
  qryScar.SQL.Add('WHERE asistencias.fecha = :fecha');
  qryScar.SQL.Add('GROUP BY asistencias.fecha, cuadrillas.Cuadrilla, asistencias.ID');
  qryScar.Parameters.ParamByName('fecha').DataType:=ftDate;
  qryScar.Parameters.ParamByName('fecha').Value:=encodedate(YearOf(ADate),MonthOf(Adate),DayOf(ADate));
  qryScar.Prepared:=true;
  try
    qryscar.ExecSQL;
    if qryScar.RowsAffected>0 then
      PayrollDCreate(ADate);
  finally
    qryScar.Close;
  end;
end;


procedure Tdm.adoLog1CalcFields(DataSet: TDataSet);
begin
  qryPersonas.Close;
  qryPersonas.Parameters[0].Value:=adoLog1ID.Value;
  try
    qryPersonas.Open;
    if qryPersonas.RecordCOunt>0 then
      adoLog1apenom.Value:=qryPersonas.Fields.Fields[0].AsString
    else
      adoLog1apenom.Value:='<Desconocido>';
  finally
    qryPersonas.Close;
  end;
end;

procedure Tdm.adoPer1CalcFields(DataSet: TDataSet);
begin
  adoPer1ApeNom.Value:=trim(adoPer1Apellido.Value)+' '+adoPer1Nombre.Value;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ScarDBPath:=SysUtils.GetCurrentDir+'\';
  adoCnx.Close;
  adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+ScarDBPath+ScarDBName+';Mode=Share Deny None;';
  adoCnx.Connected:=true;
end;

procedure Tdm.DepartmentsBeforePost(DataSet: TDataSet);
begin
  dm.Departments.FieldByName('modified_on').Value:=now;
end;

procedure Tdm.dsJrnStateChange(Sender: TObject);
begin
  if dsJrn.State = dsInsert then
    dsJrn.DataSet.Cancel;
end;

procedure Tdm.EmployeesBeforePost(DataSet: TDataSet);
begin

    Employees.FieldByName('modified_on').Value:=now;
end;

procedure Tdm.tblUsersBeforePost(DataSet: TDataSet);
begin
  dm.tblUsers.FieldByName('modified_on').Value:=now;
end;

function Tdm.PayrollExist(ADate: TDate): boolean;
var
  aPayrollId: integer;
begin
  Result:=false;
  qryScar.Close;
  qryScar.SQL.Clear;
  qryScar.SQL.Add('SELECT * FROM payrolld WHERE period =:period');
  qryScar.Parameters.ParamByName('period').DataType:=ftDate;
  qryScar.Parameters.ParamByName('period').Value:=encodedate(YearOf(ADate),MonthOf(Adate),DayOf(ADate));
  qryScar.Prepared:=true;
  try
    qryScar.Open;
    if qryScar.RecordCount>0 then
    Result:=true
  finally
    qryScar.Close;
  end;
end;

procedure Tdm.qEmployeesAfterScroll(DataSet: TDataSet);
var
  b: boolean;
begin
  if Employees.Active then
  begin
    b:=Employees.Locate('id',qEmployees.FieldByName('id_cuil').Value,[]);
  end;
  if b then;
  
end;

end.
