program GCM;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untBancoDados in 'untBancoDados.pas',
  untUsersModel in 'untUsersModel.pas',
  untUsersDAO in 'untUsersDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
