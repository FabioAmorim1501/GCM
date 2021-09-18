unit untUsersDAO;

interface

uses
  Generics.Collections, DB, FireDAC.Comp.Client, FireDAC.Stan.Param, untUsersModel;

type

  TUserDAO = class(TUserBase)
  private
    FIdF, FNameF, FUsernameF, FEmailF, FStreetF, FSuiteF, FCityF, FZipCodeF, FLatF, FLngF, FPhoneF, FWebsiteF,
      FCompatnyNameF, FCompanyCatchPhraseF, FCompanyBSF: TField;
    procedure FillFields(const AQry: TFDQuery);
  public
    function Refresh: TUserDAO;
    function Insert: Integer;
    function Update: Integer;
    function Delete: Boolean;
  end;

  TUserListDAO = class(TUserList)
    function LoadFromDB(const AFilter: String = 'TRUE'): TArray<TUserBase>;
  end;

implementation

uses
  untBancoDados, System.SysUtils;

{ TUserDAO }

function TUserDAO.Delete: Boolean;
var
  qryDelete: TFDQuery;
begin
  qryDelete := TBancoDados.CriarQueryConectada(nil);
  try
    qryDelete.SQL.Text := 'DELETE FROM USERS WHERE ID = :ID';
    qryDelete.ParamByName('ID').AsExtended := Self.Id;
    TBancoDados.IniciarTransacao;
    try
      qryDelete.ExecSQL;
      TBancoDados.Commit;
    except
      on E: Exception do
      begin
        TBancoDados.Rollback;
        Raise E;
      end;
    end;
    Result := qryDelete.RowsAffected > 0;
  finally
    qryDelete.Free;
  end;
end;

procedure TUserDAO.FillFields(const AQry: TFDQuery);
begin
  FIdF := AQry.FieldByName('ID');
  FNameF := AQry.FieldByName('NAME');
  FUsernameF := AQry.FieldByName('USERNAME');
  FEmailF := AQry.FieldByName('EMAIL');
  FStreetF := AQry.FieldByName('STREET');
  FSuiteF := AQry.FieldByName('SUITE');
  FCityF := AQry.FieldByName('CITY');
  FZipCodeF := AQry.FieldByName('ZIPCODE');
  FLatF := AQry.FieldByName('LAT');
  FLngF := AQry.FieldByName('LNG');
  FPhoneF := AQry.FieldByName('PHONE');
  FWebsiteF := AQry.FieldByName('WEBSITE');
  FCompatnyNameF := AQry.FieldByName('COMPANY_NAME');
  FCompanyCatchPhraseF := AQry.FieldByName('COMPANY_CATCHPHRASE');
  FCompanyBSF := AQry.FieldByName('COMPANY_BS');
end;

function TUserDAO.Insert: Integer;
var
  qryInsert: TFDQuery;
begin
  qryInsert := TBancoDados.CriarQueryConectada(nil);
  try
    qryInsert.SQL.Text :=
      'INSERT INTO USERS (ID, NAME, USERNAME, EMAIL, STREET, SUITE, CITY, ZIPCODE, LAT, LNG, PHONE, WEBSITE, COMPANY_NAME, '
     +'COMPANY_CATCHPHRASE, COMPANY_BS) VALUES (DEFAULT, :NAME, :USERNAME, :EMAIL, :STREET, :SUITE, :CITY, :ZIPCODE, :LAT, '
     +':LNG, :PHONE, :WEBSITE, :COMPANY_NAME, :COMPANY_CATCHPHRASE, :COMPANY_BS) RETURNING ID';
    qryInsert.ParamByName('NAME').Value := Name;
    qryInsert.ParamByName('USERNAME').Value := Username;
    qryInsert.ParamByName('EMAIL').Value := Email;
    qryInsert.ParamByName('STREET').Value := Address.Street;
    qryInsert.ParamByName('SUITE').Value := Address.Suite;
    qryInsert.ParamByName('CITY').Value := Address.City;
    qryInsert.ParamByName('ZIPCODE').Value := Address.Zipcode;
    qryInsert.ParamByName('LAT').Value := Address.Geo.Lat;
    qryInsert.ParamByName('LNG').Value := Address.Geo.Lng;
    qryInsert.ParamByName('PHONE').Value := Phone;
    qryInsert.ParamByName('WEBSITE').Value := Website;
    qryInsert.ParamByName('COMPANY_NAME').Value := Company.Name;
    qryInsert.ParamByName('COMPANY_CATCHPHRASE').Value := Company.CatchPhrase;
    qryInsert.ParamByName('COMPANY_BS').Value := Company.Bs;
    TBancoDados.IniciarTransacao;
    try
      qryInsert.Open;
      if qryInsert.IsEmpty then
        Result := -1
      else
        Result := qryInsert.FieldByName('ID').Value;
      TBancoDados.Commit;
    except
      on E: Exception do
      begin
        TBancoDados.Rollback;
        Raise E;
      end;
    end;
  finally
    qryInsert.Free;
  end;
end;

function TUserDAO.Refresh: TUserDAO;
var
  qrySelect: TFDQuery;
begin
  qrySelect := TBancoDados.CriarQueryConectada(nil);
  try
    qrySelect.SQL.Text := 'SELECT * FROM USERS WHERE ID := :ID';
    qrySelect.ParamByName('ID').AsExtended := Self.Id;
    qrySelect.Open;
    if not(qrySelect.IsEmpty) then
    begin
      FillFields(qrySelect);

      Self
        .F_Id(FIdF.Value)
        .F_Name(FNameF.Value)
        .F_Username(FUsernameF.Value)
        .F_Email(FEmailF.Value)
        .F_Address(
          Self
           .Address
           .F_Street(FStreetF.Value)
           .F_Suite(FSuiteF.Value)
           .F_City(FCityF.Value)
           .F_Zipcode(FZipCodeF.Value)
           .F_Geo(Self.Address.Geo.F_Lat(FLatF.Value).F_Lng(FLngF.Value))
        ).F_Phone(FPhoneF.Value)
        .F_Website(FWebsiteF.Value)
        .F_Company(
          Self
            .Company
            .F_Name(FCompatnyNameF.Value)
            .F_CatchPhrase(FCompanyCatchPhraseF.Value)
            .F_Bs(FCompanyBSF.Value)
        );
    end;
  finally
    qrySelect.Free;
  end;
  Result := Self;
end;

function TUserDAO.Update: Integer;
var
  qryUpdate: TFDQuery;
begin
  qryUpdate := TBancoDados.CriarQueryConectada(nil);
  try
    qryUpdate.SQL.Text :=
      'UPDATE OR INSERT INTO USERS (ID, NAME, USERNAME, EMAIL, STREET, SUITE, CITY, ZIPCODE, LAT, LNG, PHONE, WEBSITE, '
     +'COMPANY_NAME, COMPANY_CATCHPHRASE, COMPANY_BS) VALUES (:ID, :NAME, :USERNAME, :EMAIL, :STREET, :SUITE, :CITY, '
     +':ZIPCODE, :LAT, :LNG, :PHONE, :WEBSITE, :COMPANY_NAME, :COMPANY_CATCHPHRASE, :COMPANY_BS) MATCHING (ID) ';
    qryUpdate.ParamByName('ID').Value := Id;
    qryUpdate.ParamByName('NAME').Value := Name;
    qryUpdate.ParamByName('USERNAME').Value := Username;
    qryUpdate.ParamByName('EMAIL').Value := Email;
    qryUpdate.ParamByName('STREET').Value := Address.Street;
    qryUpdate.ParamByName('SUITE').Value := Address.Suite;
    qryUpdate.ParamByName('CITY').Value := Address.City;
    qryUpdate.ParamByName('ZIPCODE').Value := Address.Zipcode;
    qryUpdate.ParamByName('LAT').Value := Address.Geo.Lat;
    qryUpdate.ParamByName('LNG').Value := Address.Geo.Lng;
    qryUpdate.ParamByName('PHONE').Value := Phone;
    qryUpdate.ParamByName('WEBSITE').Value := Website;
    qryUpdate.ParamByName('COMPANY_NAME').Value := Company.Name;
    qryUpdate.ParamByName('COMPANY_CATCHPHRASE').Value := Company.CatchPhrase;
    qryUpdate.ParamByName('COMPANY_BS').Value := Company.Bs;
    TBancoDados.IniciarTransacao;
    try
      qryUpdate.ExecSQL;
      TBancoDados.Commit;
    except
      on E: Exception do
      begin
        TBancoDados.Rollback;
        Raise E;
      end;
    end;
    Result := qryUpdate.RowsAffected;
  finally
    qryUpdate.Free;
  end;
end;

{ TUserListDAO }

function TUserListDAO.LoadFromDB(const AFilter: String): TArray<TUserBase>;
var
  qrySelect: TFDQuery;
  List: TList<TUserBase>;
  User: TUserBase;
  IdF, NameF, UsernameF, EmailF, StreetF, SuiteF, CityF, ZipCodeF, LatF, LngF, PhoneF, WebsiteF, CompatnyNameF,
    CompanyCatchPhraseF, CompanyBSF: TField;
begin
  Result := nil;
  qrySelect := TBancoDados.CriarQueryConectada(nil);
  try
    qrySelect.SQL.Text := 'SELECT * FROM USERS WHERE &FILTER ORDER BY ID DESC';
    qrySelect.MacroByName('FILTER').AsRaw := AFilter;
    qrySelect.Open;
    if not(qrySelect.IsEmpty) then
    begin
      List := TList<TUserBase>.Create;
      IdF := qrySelect.FieldByName('ID');
      NameF := qrySelect.FieldByName('NAME');
      UsernameF := qrySelect.FieldByName('USERNAME');
      EmailF := qrySelect.FieldByName('EMAIL');
      StreetF := qrySelect.FieldByName('STREET');
      SuiteF := qrySelect.FieldByName('SUITE');
      CityF := qrySelect.FieldByName('CITY');
      ZipCodeF := qrySelect.FieldByName('ZIPCODE');
      LatF := qrySelect.FieldByName('LAT');
      LngF := qrySelect.FieldByName('LNG');
      PhoneF := qrySelect.FieldByName('PHONE');
      WebsiteF := qrySelect.FieldByName('WEBSITE');
      CompatnyNameF := qrySelect.FieldByName('COMPANY_NAME');
      CompanyCatchPhraseF := qrySelect.FieldByName('COMPANY_CATCHPHRASE');
      CompanyBSF := qrySelect.FieldByName('COMPANY_BS');

      while not(qrySelect.EoF) do
      begin
        User := TUserBase.Create;
        List.Add(User.F_Id(IdF.Value).F_Name(NameF.Value).F_Username(UsernameF.Value).F_Email(EmailF.Value)
          .F_Address(User.F_Address.F_Street(StreetF.Value).F_Suite(SuiteF.Value).F_City(CityF.Value)
          .F_Zipcode(ZipCodeF.Value).F_Geo(User.F_Address.Geo.F_Lat(LatF.Value).F_Lng(LngF.Value))).F_Phone(PhoneF.Value)
          .F_Website(WebsiteF.Value).F_Company(User.F_Company.F_Name(CompatnyNameF.Value)
          .F_CatchPhrase(CompanyCatchPhraseF.Value).F_Bs(CompanyBSF.Value)));
        qrySelect.Next;
      end;
      Result := List.ToArray;
    end;
  finally
    qrySelect.Free;
  end;
end;

end.
