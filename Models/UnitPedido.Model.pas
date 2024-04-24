unit UnitPedido.Model;

interface
uses
  UnitPortalORM.Model,
  UnitItemPedido.Model, UnitCliente.Model;

type
  [TNomeTabela('PEDIDOS', 'PED_CODIGO')]
  TPedidoModel = class(TTabela)
  private
    FCodigo: integer;
    FData: TDateTime;
    FValorTotal: Currency;
    FItens: TArray<TTabela>;
    FCodCliente: integer;
    FCliente: TClienteModel;
    FEstadoPedido: string;
  published
    [TCampo('PED_CODIGO', 'INTEGER NOT NULL PRIMARY KEY')]
    property Codigo: integer read FCodigo write FCodigo;
    [TCampo('PED_DATA', 'DATE')]
    property Data: TDateTime read FData write FData;
    [TCampo('PED_VALOR_TOTAL', 'NUMERIC(9,2)')]
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    [TCampo('PED_CLI', 'INTEGER')]
    property CodCliente: integer read FCodCliente write FCodCliente;
    [TRelacionamento('ITENS_PEDIDOS', 'IP_CODIGO', 'IP_COD_PED', TItensPedido, TTipoRelacionamento.UmPraMuitos)]
    property Itens: TArray<TTabela> read FItens write FItens;
    [TRelacionamento('CLIENTES', 'CLI_CODIGO', 'PED_CLI', TClienteModel, TTipoRelacionamento.UmPraUm)]
    property Cliente: TClienteModel read FCliente write FCliente;
    [TCampo('PED_ESTADO', 'VARCHAR(30)')]
    property EstadoPedido: string read FEstadoPedido write FEstadoPedido;
  end;

implementation

end.
