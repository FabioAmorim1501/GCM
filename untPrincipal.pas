unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, FireDAC.DApt, FireDAC.Stan.Def, FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Async;

type
  TfrmPrincipal = class(TForm)
    btnFeedDB: TButton;
    btnShowData: TButton;
    btnDelete: TButton;
    grdDados: TDBGrid;
    cdsDados: TClientDataSet;
    dsDados: TDataSource;
    cdsDadosID: TIntegerField;
    cdsDadosNAME: TStringField;
    cdsDadosUSERNAME: TStringField;
    cdsDadosEMAIL: TStringField;
    cdsDadosSTREET: TStringField;
    cdsDadosSUITE: TStringField;
    cdsDadosCITY: TStringField;
    cdsDadosZIPCODE: TStringField;
    cdsDadosLAT: TStringField;
    cdsDadosLNG: TStringField;
    cdsDadosPHONE: TStringField;
    cdsDadosWEBSITE: TStringField;
    cdsDadosCOMPANY_NAME: TStringField;
    cdsDadosCOMPANY_CATCHPHRASE: TStringField;
    cdsDadosCOMPANY_BS: TStringField;
    rstUsers: TRESTClient;
    rrqUsers: TRESTRequest;
    btnInsert: TButton;
    btnUpdate: TButton;
    procedure btnShowDataClick(Sender: TObject);
    procedure btnFeedDBClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cdsDadosAfterPost(DataSet: TDataSet);
    procedure btnInsertClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    procedure ShowData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  untUsersDAO, untUsersModel, REST.Json, System.JSON;

{$R *.dfm}

procedure TfrmPrincipal.btnDeleteClick(Sender: TObject);
var
  User: TUserDAO;
begin
  User := TUserDAO.Create;
  try
    if TUserDAO(User.F_Id(cdsDadosID.Value)).Delete then
      ShowData;
  finally
    User.Free;
  end;
end;

procedure TfrmPrincipal.btnFeedDBClick(Sender: TObject);
var
  Users: TUserList;
  Item: TUserBase;
  User: TUserDAO absolute Item;
begin
  rrqUsers.Execute;
  if rrqUsers.Response.StatusCode = 200 then
  begin
    Users := TUserListDAO.Create;
    try
      Users := TUserList.FromJsonString('{"items":' + rrqUsers.Response.JSONValue.ToJSON + '}');
      for Item in Users.Items do
      begin
        User.Update;
      end;
    finally
      Users.Free;
    end;
    ShowData;
  end;
end;

procedure TfrmPrincipal.btnInsertClick(Sender: TObject);
begin
  cdsDados.Insert;
  cdsDadosNAME.FocusControl;
end;

procedure TfrmPrincipal.btnShowDataClick(Sender: TObject);
begin
  ShowData;
end;

procedure TfrmPrincipal.btnUpdateClick(Sender: TObject);
begin
  cdsDados.Edit;
  cdsDadosNAME.FocusControl;
end;

procedure TfrmPrincipal.cdsDadosAfterPost(DataSet: TDataSet);
var
  User: TUserDAO;
begin
  if cdsDados.Tag = 0 then
  begin
    User := TUserDAO.Create;
    try
      User
        .F_Id(cdsDadosID.Value)
        .F_Name(cdsDadosNAME.AsString)
        .F_Username(cdsDadosUSERNAME.AsString)
        .F_Email(cdsDadosEMAIL.AsString)
        .F_Address(
          User.Address
            .F_Street(cdsDadosSTREET.AsString)
            .F_Suite(cdsDadosSUITE.AsString)
            .F_City(cdsDadosCITY.AsString)
            .F_Zipcode(cdsDadosZIPCODE.AsString)
            .F_Geo(User.Address.Geo.F_Lat(cdsDadosLAT.AsString).F_Lng(cdsDadosLNG.AsString)))
        .F_Phone(cdsDadosPHONE.AsString)
        .F_Website(cdsDadosWEBSITE.AsString)
        .F_Company(
            User.Company
              .F_Name(cdsDadosCOMPANY_NAME.AsString)
              .F_CatchPhrase(cdsDadosCOMPANY_CATCHPHRASE.AsString)
              .F_Bs(cdsDadosCOMPANY_BS.AsString));
      User.Update;
    finally
      User.Free;
    end;
  end;
end;

procedure TfrmPrincipal.ShowData;
var
  Users: TUserListDAO;
  Item: TUserBase;
  User: TUserDAO absolute Item;
begin
  Users := TUserListDAO.Create;
  cdsDados.DisableControls;
  cdsDados.Tag := 1;
  try
    Users.Items := Users.LoadFromDB;
    if Length(Users.Items) > 0 then
    begin
      cdsDados.Close;
      cdsDados.CreateDataSet;
      cdsDados.Open;
      for Item in Users.Items do
      begin
        cdsDados.Insert;
        try
          cdsDadosID.Value := User.Id;
          cdsDadosNAME.AsString := User.Name;
          cdsDadosUSERNAME.AsString := User.Username;
          cdsDadosEMAIL.AsString := User.Email;
          cdsDadosSTREET.AsString := User.Address.Street;
          cdsDadosSUITE.AsString := User.Address.Suite;
          cdsDadosCITY.AsString := User.Address.City;
          cdsDadosZIPCODE.AsString := User.Address.Zipcode;
          cdsDadosLAT.Value := User.Address.Geo.Lat;
          cdsDadosLNG.Value := User.Address.Geo.Lng;
          cdsDadosPHONE.AsString := User.Phone;
          cdsDadosWEBSITE.AsString := User.Website;
          cdsDadosCOMPANY_NAME.AsString := User.Company.Name;
          cdsDadosCOMPANY_CATCHPHRASE.AsString := User.Company.CatchPhrase;
          cdsDadosCOMPANY_BS.AsString := User.Company.Bs;
          cdsDados.Post;
        except
          on E: Exception do
          begin
            cdsDados.Cancel;
            Raise E;
          end;
        end;
      end;
    end;
  finally
    cdsDados.EnableControls;
    cdsDados.Tag := 0;
    Users.Free;
  end;
end;

end.
