unit UnitEstados.Pedido;

interface
type
  TEstadoPedido = (aguardando, naFilaDePreparo, prontoParaEntrega, Entregue);

  function EstadoPedidoToStr(Estado: TEstadoPedido): string;

implementation

function EstadoPedidoToStr(Estado: TEstadoPedido): string;
begin
  case Estado of
    aguardando: Result := 'AGUARDANDO';
    naFilaDePreparo: Result := 'NA_FILA_DE_PREPARO';
    prontoParaEntrega: Result := 'PRONTO_PARA_ENTREGA';
    Entregue: Result := 'ENTREGUE';
  end;
end;

end.
