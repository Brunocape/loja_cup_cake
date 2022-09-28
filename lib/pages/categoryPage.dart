import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/itemController.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/categoriaModel.dart';
import 'package:loja_cup_cake/models/itemModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/tiles/productTile.dart';
class CategoryPage extends StatelessWidget {

  Categoria categoria;
  UsuarioModel user;
  CartModel cartModel;
  CategoryPage(this.categoria,this.cartModel, this.user);


  Item_Controller item_controller = Item_Controller();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(categoria.descricao!),
            centerTitle: true,
            bottom:const TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on),),
                Tab(icon: Icon(Icons.list),)
              ],
            ),
          ),
          body: FutureBuilder<List<Item>>(
              future: item_controller.GetItensByCat(categoria.id!),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator(),);
                else
                  // ignore: curly_braces_in_flow_control_structures
                  return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                            padding:const  EdgeInsets.all(4.0),
                            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              Item data = snapshot.data![index];
                              return ProductTile("grid", data, user, cartModel);
                            }
                        ),
                        ListView.builder(
                            padding: EdgeInsets.all(4.0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              Item data = snapshot.data![index];
                              return ProductTile("list", data, user, cartModel);
                            }
                        )
                      ]
                  );
              }
          )
      ),
    );
  }
}
