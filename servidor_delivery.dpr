program servidor_delivery;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Json,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  UnitPedido.Model in 'Models\UnitPedido.Model.pas',
  UnitCliente.Model in 'Models\UnitCliente.Model.pas',
  UnitItemPedido.Model in 'Models\UnitItemPedido.Model.pas',
  UnitCliente.Controller in 'Controllers\Cliente\UnitCliente.Controller.pas',
  UnitConstants in 'UnitConstants.pas',
  UnitDatabase in 'Database\UnitDatabase.pas',
  UnitPedidos.Controller in 'Controllers\Pedidos\UnitPedidos.Controller.pas',
  UnitEstados.Pedido in 'Models\UnitEstados.Pedido.pas';

var
  Porta: string;
  Port: integer;
begin
  //middlewares
  THorse.Use(cors)
        .Use(Jhonson);

  //controllers
  TClienteController.Router;
  TPedidosController.Router;

  Porta := GetEnvironmentVariable('PORT');//8080

  if not Porta.IsEmpty then
    Port := GetEnvironmentVariable('PORT').ToInteger()
  else
    Port := 3333;

  //inicialização
  THorse.Listen(Port,
  procedure
  begin
    Writeln('Server is running on port '+THorse.Port.ToString);
  end);
end.
