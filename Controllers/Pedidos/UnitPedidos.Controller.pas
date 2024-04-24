unit UnitPedidos.Controller;

interface
uses
  System.SysUtils,
  Horse,
  UnitPedido.Model,
  UnitConnection.Model.Interfaces;

type
  TPedidosController = class
    class procedure Router;
    class procedure GetAll(Req: THorseRequest; Res: THorseResponse);
    class procedure GetOne(Req: THorseRequest; Res: THorseResponse);
    class procedure UpdateState(Req: THorseRequest; Res: THorseResponse);
  end;

implementation

{ TControllerPedidos }

uses
  System.Json,
  UnitTabela.Helper.Json,
  UnitDatabase;

class procedure TPedidosController.GetAll(Req: THorseRequest; Res: THorseResponse);
var
  Query: iQuery;
  Pedido: TPedidoModel;
  aJson: TJSONArray;
begin
  Query := TDatabase.Query;
  Query.Open('SELECT PED_CODIGO FROM PEDIDOS');
  aJson := TJSONArray.Create;
  Query.DataSet.First;
  while not Query.DataSet.Eof do
  begin
    Pedido := TPedidoModel.Create(TDatabase.Connection);
    try
      Pedido.BuscaDadosTabela(Query.DataSet.FieldByName('PED_CODIGO').AsInteger);
      aJson.AddElement(TJSONObject.ParseJSONValue(Pedido.ToJson) as TJSONObject);
    finally
      Pedido.DisposeOf;
    end;
    Query.DataSet.Next;
  end;
  Res.Send<TJSONArray>(aJson);
end;

class procedure TPedidosController.GetOne(Req: THorseRequest; Res: THorseResponse);
var
  id: Integer;
  Pedido: TPedidoModel;
begin
  if Req.Params.ContainsKey('id') then
    id := Req.Params.Items['id'].ToInteger;
  Pedido := TPedidoModel.Create(TDatabase.Connection);
  try
    Pedido.BuscaDadosTabela(id);
    Res.Send<TJSONObject>(TJSONObject.ParseJSONValue(Pedido.ToJson) as TJSONObject);
  finally
    Pedido.DisposeOf;
  end;
end;

class procedure TPedidosController.Router;
begin
  THorse.Get('/pedidos/:id', GetOne)
        .Get('/pedidos', GetAll)
        .Put('/pedidos/:id', UpdateState)
end;

class procedure TPedidosController.UpdateState(Req: THorseRequest; Res: THorseResponse);
var
  Pedido: TPedidoModel;
  id: Integer;
  bodyJson: TJSONObject;
begin
  if not Req.Params.ContainsKey('id') then
    raise Exception.Create('Id não informado!');
  id := Req.Params.Items['id'].ToInteger();
  bodyJson := Req.Body<TJSONObject>;
  Pedido := TPedidoModel.Create(TDatabase.Connection);
  try
    Pedido.BuscaDadosTabela(id);
    Pedido.EstadoPedido := bodyJson.GetValue<string>('estado');
    Pedido.SalvaNoBanco();
  finally
    Pedido.DisposeOf;
  end;
end;

end.
