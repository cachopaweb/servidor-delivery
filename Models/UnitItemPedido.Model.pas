unit UnitItemPedido.Model;

interface
uses
  UnitPortalORM.Model;

type
  [TNomeTabela('ITENS_PEDIDOS', 'IP_CODIGO')]
  TItensPedido = class(TTabela)
  private
    FCodigo: integer;
    FNome: string;
    FQuantidade: double;
    FValorUnitario: Currency;
    FValorTotal: Currency;
    FCodPedido: integer;
  published
    [TCampo('IP_CODIGO', 'INTEGER NOT NULL PRIMARY KEY')]
    property Codigo: integer read FCodigo write FCodigo;
    [TCampo('IP_NOME', 'VARCHAR(200)')]
    property Nome: string read FNome write FNome;
    [TCampo('IP_QUANTIDADE', 'NUMERIC(9,2)')]
    property Quantidade: double read FQuantidade write FQuantidade;
    [TCampo('IP_VALOR_UNIT', 'NUMERIC(9,2)')]
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    [TCampo('IP_VALOR_TOTAL', 'NUMERIC(9,2)')]
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    [TCampo('IP_COD_PED', 'INTEGER')]
    property CodPedido: integer read FCodPedido write FCodPedido;
  end;

implementation

end.
