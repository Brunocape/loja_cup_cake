import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/pedidoModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/tiles/pedidoTile.dart';

class MeusPedidosPage extends StatefulWidget {
  UsuarioModel user;
  MeusPedidosPage(this.user);

  @override
  _MeusPedidosPageState createState() => _MeusPedidosPageState(user);
}

class _MeusPedidosPageState extends State<MeusPedidosPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<PedidoModel> pedidos = [];
  UsuarioModel user;
  _MeusPedidosPageState(this.user);
  @override
  void initState() {
    super.initState();
    if(user.isLoggedIn()){
      user.GetPedidos().then((value) => {
        setState(() {
          pedidos = value;
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
                  child:user.isLoggedIn()?  ListView(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children:pedidos.map((e) {
                      return Pedidotile(e);
                    }).toList(),
                  ): const Center(child: Padding(padding: EdgeInsets.all(18),
                    child: Text("Você nao esta logado",style: TextStyle(fontSize: 20),),),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
