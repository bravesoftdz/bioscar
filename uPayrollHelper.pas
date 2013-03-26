unit uPayrollHelper;

interface

uses DBClient;

type
  TPayrollHelper = class
    FDate: TDate;
    FGroup: string;
    FResultSet: TClientDataSet;

    public
    constructor PayrollHelper(Date: TDate; Group: string);
    procedure GetResultSet;
  end;

implementation

{ TPayrollHelper }

procedure TPayrollHelper.GetResultSet;
begin
  FResultset.ProviderName:='myProv';
end;

constructor TPayrollHelper.PayrollHelper(Date: TDate; Group: string);
begin
  FDate:=Date;
  FGroup:=Group;
  FResultSet:=TClientDataSet.Create(nil);
end;

end.
