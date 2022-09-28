import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/cartPage.dart';
import 'package:loja_cup_cake/services/loadAndToast.dart';

class CartButton extends StatelessWidget {
  UsuarioModel user;
  CartButton(this.user);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: ()async{
        CartModel cartModel = CartModel();
        if(user.isLoggedIn()) {
          LoadAndToast lt = LoadAndToast();
          lt.showLoaderDialog(context, "Aguarde!");
          await cartModel.loadCartItems(user.id!);
          Navigator.pop(context);
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartPage(cartModel, user))
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
