import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';

class CartPrice extends StatefulWidget {
  final VoidCallback buy;
  CartModel cartModel;

  CartPrice(this.buy, this.cartModel);

  @override
  State<CartPrice> createState() => _CartPriceState(buy, cartModel);
}

class _CartPriceState extends State<CartPrice> {
  final VoidCallback buy;
  CartModel cartModel;

  double price = 0;
  double discount = 0;
  double ship = 0;

  _CartPriceState(this.buy, this.cartModel);
  @override
  void initState() {
    // TODO: implement initState
     price = cartModel.getProductsPrice();
     discount = cartModel.getDiscount();
     ship = cartModel.getShipPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text("R\$ ${discount.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Entrega"),
                    Text("R\$ ${ship.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                      style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("R\$ ${(price + ship - discount).toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),)
                  ],
                ),
                SizedBox(height: 12.0,),
                ElevatedButton(
                  child: Text("Finalizar Pedido"),
                  onPressed: buy,
                )
              ],
            ),
        ),
    );
  }
}



