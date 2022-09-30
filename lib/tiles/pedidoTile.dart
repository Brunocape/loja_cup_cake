import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/pedidoModel.dart';
class Pedidotile extends StatelessWidget {
  PedidoModel pedidoModel;
Pedidotile(this.pedidoModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color:Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x1F000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        8, 8, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Pedido :' + pedidoModel.id.toString(),
                          style: const TextStyle(
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        8, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:  ' + _getStatusPedidos(),
                          style: const TextStyle(
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        8, 0, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                'Total Itens',
                                style:  TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                'Valor',
                                style:TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        8, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                pedidoModel.GetTotalItens().toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                pedidoModel.vlrLiquido.toString(),
                                style:const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusPedidos(){
    String retorno = "";
     if(pedidoModel.status == 1){
       retorno="Em produção";
    }else if(pedidoModel.status == 2){
       retorno="Em separação";
    }else if(pedidoModel.status == 3){
       retorno="Saiu para entrega";
     }else{
       retorno="Entregue";
     }
     return retorno;
  }

}
