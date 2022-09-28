import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/loginPage.dart';
import 'package:loja_cup_cake/tiles/cart_tile.dart';

class CartPage extends StatelessWidget {

  CartModel cartModel;
  UsuarioModel user;
  CartPage(this.cartModel, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child:
                Text(
                  "${cartModel.products.length } ${cartModel.products.length == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                )
          )
        ],
      ),
      body:_getWidget(context)
    );
  }

  Widget _getWidget(BuildContext context) {
    if (cartModel.isLoading && user.isLoggedIn()) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (!user.isLoggedIn()) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.remove_shopping_cart,
              size: 80.0, color: Theme
                  .of(context)
                  .primaryColor,),
            SizedBox(height: 16.0,),
            Text("Faça o login para adicionar produtos!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            ElevatedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage())
                );
              },
            )
          ],
        ),
      );
    } else if (cartModel.products == null || cartModel.products.length == 0) {
      return Center(
        child: Text("Nenhum produto no carrinho!",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
      );
    } else {
      return ListView(
        children: <Widget>[
          Column(
            children: cartModel.products.map(
                    (product) {
                      return  CartTile(cartModel, product, user);
                }
            ).toList(),
          ),
          // DiscountCard(),
          // ShipCard(),
          //  CartPrice(() async {
          //    String orderId = await model.finishOrder();
          //    if(orderId != null)
          //      Navigator.of(context).pushReplacement(
          //        MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
          //      );
          //  }),
        ],
      );
    }
  }
}










