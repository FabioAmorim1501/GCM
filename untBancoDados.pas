unit untBancoDados;

interface

uses
  Classes, FireDAC.Comp.Client;

type
  TBancoDados = class(TPersistent)
  private
    class var FConexaoBD: TFDConnection;
  public
    class function ConexaoBD: TFDConnection; static;
    class function CriarQueryConectada(const AQuery: TFDQuery = nil): TFDQuery; static;
    class function IniciarTransacao: TFDConnection; static;
    class function Rollback: TFDConnection; static;
    class function Commit: TFDConnection; static;
  end;

implementation

uses
  Forms;

{ TBancoDados }
class function TBancoDados.CriarQueryConectada(const AQuery: TFDQuery): TFDQuery;
begin
  if ((AQuery = nil) or (not(Assigned(AQuery))) or (AQuery.Name = '')) then
    Result := TFDQuery.Create(Application)
  else
    Result := AQuery;
  Result.Connection := ConexaoBD;
end;

class function TBancoDados.ConexaoBD: TFDConnection;
begin
  if not(Assigned(FConexaoBD)) then
  begin
    FConexaoBD := TFDConnection.Create(Application);
    FConexaoBD.ConnectionName := 'gcm';
    FConexaoBD.Connected := True;
  end;
  Result := FConexaoBD;
end;

class function TBancoDados.IniciarTransacao: TFDConnection;
begin
  ConexaoBD.StartTransaction;
  Result := ConexaoBD;
end;

class function TBancoDados.Rollback: TFDConnection;
begin
  ConexaoBD.Rollback;
  Result := ConexaoBD;
end;

class function TBancoDados.Commit: TFDConnection;
begin
  ConexaoBD.Commit;
  Result := ConexaoBD;
end;

initialization

RegisterClass(TBancoDados);

end.
