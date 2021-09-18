unit untUsersModel;

interface

uses
  Generics.Collections, REST.Json.Types, Rest.Json;

type

  TCompanyBase = class
  private
    [JSONName('name')]
    FName: String;
    [JSONName('catchPhrase')]
    FCatchPhrase: String;
    [JSONName('bs')]
    FBs: String;
  public
    function F_Bs: String; overload;
    function F_Bs(const ABs: String): TCompanyBase; overload;
    function F_CatchPhrase: String; overload;
    function F_CatchPhrase(const AcatchPhrase: String): TCompanyBase; overload;
    function F_Name: String; overload;
    function F_Name(const AName: String): TCompanyBase; overload;
    property Bs: String read FBs write FBs;
    property CatchPhrase: String read FCatchPhrase write FCatchPhrase;
    property Name: String read FName write FName;
    function ToJsonString: string;
    class function FromJsonString(const AJsonString: string): TCompanyBase;
  end;

  TGeoBase = class
  private
    [JSONName('lat')]
    FLat: String;
    [JSONName('lng')]
    FLng: String;
  public
    function F_Lat: String; overload;
    function F_Lat(const ALat: String): TGeoBase; overload;
    function F_Lng: String; overload;
    function F_Lng(const ALng: String): TGeoBase; overload;
    property Lat: String read FLat write FLat;
    property Lng: String read FLng write FLng;
    function ToJsonString: string;
    class function FromJsonString(const AJsonString: string): TGeoBase;
  end;

  TAddressBase = class
  private
    [JSONName('street')]
    FStreet: String;
    [JSONName('suite')]
    FSuite: String;
    [JSONName('city')]
    FCity: String;
    [JSONName('zipcode')]
    FZipcode: String;
    [JSONName('geo')]
    FGeo: TGeoBase;
  public
    function F_City: String; overload;
    function F_City(const ACity: String): TAddressBase; overload;
    function F_Geo: TGeoBase; overload;
    function F_Geo(const AGeo: TGeoBase): TAddressBase; overload;
    function F_Street: String; overload;
    function F_Street(const AStreet: String): TAddressBase; overload;
    function F_Suite: String; overload;
    function F_Suite(const ASuite: String): TAddressBase; overload;
    function F_Zipcode: String; overload;
    function F_Zipcode(const AZipcode: String): TAddressBase; overload;
    property City: String read FCity write FCity;
    property Geo: TGeoBase read FGeo write FGeo;
    property Street: String read FStreet write FStreet;
    property Suite: String read FSuite write FSuite;
    property Zipcode: String read FZipcode write FZipcode;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(const AJsonString: string): TAddressBase;
  end;

  TUserBase = class
  private
    [JSONName('id')]
    FId: Integer;
    [JSONName('name')]
    FName: String;
    [JSONName('username')]
    FUsername: String;
    [JSONName('email')]
    FEmail: String;
    [JSONName('address')]
    FAddress: TAddressBase;
    [JSONName('phone')]
    FPhone: String;
    [JSONName('website')]
    FWebsite: String;
    [JSONName('company')]
    FCompany: TCompanyBase;
  public
    function F_Address: TAddressBase; overload;
    function F_Address(const AAddress: TAddressBase): TUserBase; overload;
    function F_Company: TCompanyBase; overload;
    function F_Company(const ACompany: TCompanyBase): TUserBase; overload;
    function F_Email: String; overload;
    function F_Email(const AEmail: String): TUserBase; overload;
    function F_Id: Integer; overload;
    function F_Id(const AId: Integer): TUserBase; overload;
    function F_Name: String; overload;
    function F_Name(const AName: String): TUserBase; overload;
    function F_Phone: String; overload;
    function F_Phone(const APhone: String): TUserBase; overload;
    function F_Username: String; overload;
    function F_Username(const AUsername: String): TUserBase; overload;
    function F_Website: String; overload;
    function F_Website(const AWebsite: String): TUserBase; overload;
    property Address: TAddressBase read FAddress write FAddress;
    property Company: TCompanyBase read FCompany write FCompany;
    property Email: String read FEmail write FEmail;
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Phone: String read FPhone write FPhone;
    property Username: String read FUsername write FUsername;
    property Website: String read FWebsite write FWebsite;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(const AJsonString: string): TUserBase;
  end;

  TUserList = class
  private
    FItems: TArray<TUserBase>;
  public
    property Items: TArray<TUserBase> read FItems write FItems;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(const AJsonString: string): TUserList;
  end;


implementation

{ TCompanyBase }

function TCompanyBase.F_Name(const AName: String): TCompanyBase;
begin
  FName := AName;
  Result := Self;
end;

function TCompanyBase.F_Name: String;
begin
  Result := FName;
end;

function TCompanyBase.F_Bs(const ABs: String): TCompanyBase;
begin
  Result := Self;
end;

function TCompanyBase.F_Bs: String;
begin
  Result := FBs;
end;

function TCompanyBase.F_CatchPhrase: String;
begin
  Result := FCatchPhrase;
end;

function TCompanyBase.F_CatchPhrase(const AcatchPhrase: String): TCompanyBase;
begin
  FCatchPhrase := AcatchPhrase;
  Result := Self;
end;

function TCompanyBase.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TCompanyBase.FromJsonString(const AJsonString: string): TCompanyBase;
begin
  Result := TJson.JsonToObject<TCompanyBase>(AJsonString);
end;

{ TGeoBase }

function TGeoBase.F_Lat(const ALat: String): TGeoBase;
begin
  FLat := ALat;
  Result := Self;
end;

function TGeoBase.F_Lat: String;
begin
  Result := FLat;
end;

function TGeoBase.F_Lng(const ALng: String): TGeoBase;
begin
  FLng := ALng;
  Result := Self;
end;

function TGeoBase.F_Lng: String;
begin
  Result := FLng;
end;

function TGeoBase.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TGeoBase.FromJsonString(const AJsonString: string): TGeoBase;
begin
  Result := TJson.JsonToObject<TGeoBase>(AJsonString);
end;

{ TAddressBase }

function TAddressBase.F_City(const ACity: String): TAddressBase;
begin
  FCity := ACity;
  Result := Self;
end;

function TAddressBase.F_City: String;
begin
  Result := FCity;
end;

constructor TAddressBase.Create;
begin
  inherited;
  FGeo := TGeoBase.Create();
end;

destructor TAddressBase.Destroy;
begin
  FGeo.free;
  inherited;
end;

function TAddressBase.F_Zipcode(const AZipcode: String): TAddressBase;
begin
  FZipcode := AZipcode;
  Result := Self;
end;

function TAddressBase.F_Zipcode: String;
begin
  Result := FZipcode;
end;

function TAddressBase.F_Geo(const AGeo: TGeoBase): TAddressBase;
begin
  FGeo := AGeo;
  Result := Self;
end;

function TAddressBase.F_Street(const AStreet: String): TAddressBase;
begin
  FStreet := AStreet;
  Result := Self;
end;

function TAddressBase.F_Suite(const ASuite: String): TAddressBase;
begin
  FSuite := ASuite;
  Result := Self;
end;

function TAddressBase.F_Suite: String;
begin
  Result := FSuite;
end;

function TAddressBase.F_Street: String;
begin
  Result := FStreet;
end;

function TAddressBase.F_Geo: TGeoBase;
begin
  Result := FGeo;
end;

function TAddressBase.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TAddressBase.FromJsonString(const AJsonString: string): TAddressBase;
begin
  Result := TJson.JsonToObject<TAddressBase>(AJsonString);
end;

{ TUserBase }

function TUserBase.F_Address(const AAddress: TAddressBase): TUserBase;
begin
  FAddress := AAddress;
  Result := Self;
end;

function TUserBase.F_Address: TAddressBase;
begin
  Result := FAddress;
end;

constructor TUserBase.Create;
begin
  inherited;
  FAddress := TAddressBase.Create;
  FCompany := TCompanyBase.Create;
end;

destructor TUserBase.Destroy;
begin
  FAddress.free;
  FCompany.free;
  inherited;
end;

function TUserBase.F_Company(const ACompany: TCompanyBase): TUserBase;
begin
  FCompany := ACompany;
  Result := Self;
end;

function TUserBase.F_Company: TCompanyBase;
begin
  Result := FCompany;
end;

function TUserBase.F_Email: String;
begin
  Result := FEmail;
end;

function TUserBase.F_Email(const AEmail: String): TUserBase;
begin
  FEmail := AEmail;
  Result := Self;
end;

function TUserBase.F_Username(const AUsername: String): TUserBase;
begin
  FUsername := AUsername;
  Result := Self;
end;

function TUserBase.F_Username: String;
begin
  Result := FUsername;
end;

function TUserBase.F_Website: String;
begin
  Result := FWebsite;
end;

function TUserBase.F_Website(const AWebsite: String): TUserBase;
begin
  FWebsite := AWebsite;
  Result := Self;
end;

function TUserBase.F_Id: Integer;
begin
  Result := FId;
end;

function TUserBase.F_Id(const AId: Integer): TUserBase;
begin
  FId := AId;
  Result := Self;
end;

function TUserBase.F_Name(const AName: String): TUserBase;
begin
  FName := AName;
  Result := Self;
end;

function TUserBase.F_Name: String;
begin
  Result := FName;
end;

function TUserBase.F_Phone(const APhone: String): TUserBase;
begin
  FPhone := APhone;
  Result := Self;
end;

function TUserBase.F_Phone: String;
begin
  Result := FPhone;
end;

function TUserBase.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TUserBase.FromJsonString(const AJsonString: string): TUserBase;
begin
  Result := TJson.JsonToObject<TUserBase>(AJsonString);
end;

{ TJsonUsersBase }

destructor TUserList.Destroy;
var
  LItemsUser: TUserBase;
begin
  for LItemsUser in FItems do
    LItemsUser.free;

  inherited;
end;

function TUserList.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TUserList.FromJsonString(const AJsonString: string): TUserList;
begin
  Result := TJson.JsonToObject<TUserList>(AJsonString);
end;

end.
