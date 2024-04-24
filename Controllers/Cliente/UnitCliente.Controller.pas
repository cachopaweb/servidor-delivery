unit UnitCliente.Controller;

interface
uses
  System.SysUtils,
  System.Json,
  Horse;

type
  TClienteController = class
    class procedure Router;
    class procedure GetOne(Req: THorseRequest; Res: THorseResponse);
  end;

implementation

{ TClienteController }

uses
  UnitCliente.Model,
  UnitDatabase,
  UnitTabela.Helper.Json;

class procedure TClienteController.GetOne(Req: THorseRequest; Res: THorseResponse);
var
  Cliente: TClienteModel;
  Id: Integer;
begin
  if Req.Params.ContainsKey('id') then
    Id := Req.Params.Items['id'].ToInteger();
  Cliente := TClienteModel.Create(TDatabase.Connection);
  try
    Cliente.BuscaDadosTabela(Id);
    Res.Send<TJSONObject>(TJSONObject.ParseJSONValue(Cliente.ToJson) as TJSONObject);
  finally
    Cliente.DisposeOf
  end;
end;

class procedure TClienteController.Router;
begin
  THorse.Get('/cliente/:id', GetOne)
end;

end.
