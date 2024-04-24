unit UnitCliente.Model;

interface
uses
  UnitPortalORM.Model;

type
  [TNomeTabela('CLIENTES', 'CLI_CODIGO')]
  TClienteModel = class(TTabela)
  private
    FCodigo: integer;
    FNome: string;
    FEndereco: string;
    FBairro: string;
  published
    [TCampo('CLI_CODIGO', 'INTEGER NOT NULL PRIMARY KEY')]
    property Codigo: integer read FCodigo write FCodigo;
    [TCampo('CLI_NOME', 'VARCHAR(200)')]
    property Nome: string read FNome write FNome;
    [TCampo('CLI_ENDERECO', 'VARCHAR(200)')]
    property Endereco: string read FEndereco write FEndereco;
    [TCampo('CLI_BAIRRO', 'VARCHAR(100)')]
    property Bairro: string read FBairro write FBairro;
  end;

implementation

end.
