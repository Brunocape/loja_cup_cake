import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/itemModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/productPage.dart';



class ProductTile extends StatelessWidget {
  final String type;
  final Item product;
  UsuarioModel user;
  CartModel cartModel;

  ProductTile(this.type, this.product,this.user, this.cartModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ProductPage(product,user, cartModel))
        );
      },
      child: Card(
        child: type == "grid"
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.imagens![0].path!,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      product.tipo!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${product.perco!}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        )
            : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.imagens![0].path!,
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.tipo!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${product.perco!}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
