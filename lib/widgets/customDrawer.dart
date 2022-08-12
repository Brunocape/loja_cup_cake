import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/loginPage.dart';
import 'package:loja_cup_cake/tiles/drwerTile.dart';

class CustomDrawer extends StatefulWidget {

  final PageController _controller;
  UserModel model;
  CustomDrawer(this._controller, this.model);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState(_controller,model);
}

class _CustomDrawerState extends State<CustomDrawer> {

  final PageController _controller;
  UserModel model;
  _CustomDrawerState(this._controller, this.model);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.Iniciar().then((value){
      setState(() {
        model;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children:  [
                    const Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: Text(
                        "Cup Cake's \nDelivery",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                !model.isLoggedIn() ?
                                "Entre ou cadastre-se >"
                                    : "Sair",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onTap: ()async{
                                if(!model.isLoggedIn())  {
                                 var model1 = await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>LoginPage())
                                  );
                                  setState((){
                                    model = model1 ?? UserModel();
                                  });
                                } else {
                                  setState(() {
                                    model.signOut();
                                  });
                                }
                              },
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile("Inicio",Icons.home,_controller,0),
              DrawerTile("Produtos",Icons.list,_controller,1),
              DrawerTile("Onde Estamos",Icons.location_on,_controller,2),
              DrawerTile("Meus Pedidos",Icons.playlist_add_check,_controller,3),
            ],
          )
        ],
      ),
    );
  }
}




