import 'package:flutter/material.dart';
import 'package:loja_cup_cake/tiles/drwerTile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
                          children:  [
                           const Text("Olá,",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                            fontSize: 18.0),),
                            GestureDetector(
                              onTap: (){},
                              child: Text("Entre ou Cadastre-se >",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            Divider(),
              DrawerTile("Inicio",Icons.home),
              DrawerTile("Produtos",Icons.list),
              DrawerTile("Onde Estamos",Icons.location_on),
              DrawerTile("Meus Pedidos",Icons.playlist_add_check),
            ],
          )
        ],
      ),
    );
  }
}
