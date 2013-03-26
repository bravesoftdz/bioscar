program Scar;

uses
  Forms,
  uMain in 'uMain.pas' {formMain},
  uOptions in 'uOptions.pas' {formOptions},
  uDBClass in 'uDBClass.pas',
  uUtil in 'uUtil.pas',
  uCallbacks in 'uCallbacks.pas',
  uPersonal in 'uPersonal.pas' {formPersonal},
  uMaletas in 'uMaletas.pas' {formMaletas},
  uSincro in 'uSincro.pas' {formSincro},
  uAcercade in 'uAcercade.pas' {formAcercade},
  uExportar in 'uExportar.pas' {formExportTrx},
  uCuadrillas in 'uCuadrillas.pas' {formCuadrillas},
  uSplash in 'uSplash.pas' {formSplash},
  uDM in 'uDM.pas' {dm: TDataModule},
  fUsers in 'fUsers.pas' {frmUsers},
  fLogin in 'fLogin.pas' {frmLogin},
  fManual in 'fManual.pas' {frmManual},
  fImport in 'fImport.pas' {frmImport},
  uStrUtils in 'uStrUtils.pas',
  fAsistencia in 'fAsistencia.pas' {frmAsistencia},
  fMigrator in 'fMigrator.pas' {frmMigrator},
  GrFinger in 'GrFinger.pas',
  fPayroll in 'fPayroll.pas' {frmPayroll};

{$R *.res}

 begin
  Application.Initialize;
  Application.Title := 'SCAR';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformOptions, formOptions);
  Application.CreateForm(TformPersonal, formPersonal);
  Application.CreateForm(TformSincro, formSincro);
  Application.CreateForm(TformAcercade, formAcercade);
  Application.CreateForm(TformExportTrx, formExportTrx);
  Application.CreateForm(TformCuadrillas, formCuadrillas);
  Application.CreateForm(TformSplash, formSplash);
  Application.CreateForm(TfrmUsers, frmUsers);
  Application.CreateForm(TfrmManual, frmManual);
  Application.CreateForm(TfrmImport, frmImport);
  Application.CreateForm(TfrmAsistencia, frmAsistencia);
  Application.CreateForm(TfrmMigrator, frmMigrator);
  Application.CreateForm(TfrmPayroll, frmPayroll);
  {
  {$IFNDEF DEBUG}
  {if TfrmLogin.Execute then
  begin
  {$ENDIF}
  {  Application.CreateForm(TformMain, formMain);
    Application.CreateForm(TformOptions, formOptions);
    Application.CreateForm(TformPersonal, formPersonal);
    Application.CreateForm(TformMaletas, formMaletas);
    Application.CreateForm(TfrmPayroll, frmPayroll);
    Application.CreateForm(TformAcercade, formAcercade);
    Application.CreateForm(TformExportTrx, formExportTrx);
    Application.CreateForm(TfrmRMaletas, frmRMaletas);
    Application.CreateForm(TformCuadrillas, formCuadrillas);
    Application.CreateForm(TfrmUsers, frmUsers);
    Application.CreateForm(TfrmManual, frmManual);
    Application.CreateForm(TfrmImport, frmImport);
    Application.CreateForm(TfrmAsistencia, frmAsistencia);
    Application.CreateForm(TfrmMigrator, frmMigrator);
    Application.CreateForm(TfrmRAsistencias, frmRAsistencias);}
    Application.Run;
  {{$IFNDEF DEBUG}
  {end
  else
  begin
    Application.MessageBox('Debe poseer una cuenta de ususario para poder ingresar.', 'SCAR') ;
  end;
  {$ENDIF}
end.
