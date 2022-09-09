import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/cartPage.dart';

class CartButton extends StatelessWidget {
  UsuarioModel user;
  CartButton(this.user);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        CartModel cartModel = CartModel(user);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartPage(cartModel))
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
