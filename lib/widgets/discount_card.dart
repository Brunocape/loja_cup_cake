import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/cartPage.dart';
import 'package:loja_cup_cake/services/loadAndToast.dart';

class DiscountCard extends StatelessWidget {
CartModel cartModel;
UsuarioModel usuarioModel;
  DiscountCard(this.cartModel, this.usuarioModel);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: cartModel.couponCode ?? "",
              onFieldSubmitted: (text)async{
                  Map<String,dynamic> retorno = await cartModel.setCoupon(text);
                  LoadAndToast lt = LoadAndToast();
                  lt.showToast(context, retorno["mensagem"]);
                  if(retorno["status"]=="OK")
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartPage(cartModel, usuarioModel),));
              },
            ),
          )
        ],
      ),
    );
  }
}
