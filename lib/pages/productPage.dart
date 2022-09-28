import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/itemCartModel.dart';
import 'package:loja_cup_cake/models/itemModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/cartPage.dart';
import 'package:loja_cup_cake/pages/loginPage.dart';


class ProductPage extends StatefulWidget {

  final Item product;
  UsuarioModel user;
  CartModel cartModel;

  ProductPage(this.product, this.user, this.cartModel);

  @override
  _ProductPageState createState() => _ProductPageState(product, user,cartModel);
}

class _ProductPageState extends State<ProductPage> {

  final Item product;
  UsuarioModel user;
  CartModel cartModel;

  _ProductPageState(this.product, this.user,this.cartModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.tipo!),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              options: CarouselOptions(),
              items:  product.imagens!.map((img) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image( image:  NetworkImage(img.path!));
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.tipo!,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.perco!}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                ),
                const SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed:
                         (){
                      if(user.isLoggedIn()){

                        ItemCartModel itemCartModel = ItemCartModel();
                        itemCartModel.qtde = 1;
                        itemCartModel.itemId = product.id;
                        itemCartModel.usuarioId = user.id;

                        cartModel.addCartItem(itemCartModel).then((value) => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartPage(cartModel,user))
                        ));

                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>LoginPage())
                        );
                      }
                    } ,
                    child: Text(user.isLoggedIn() ? "Adicionar ao Carrinho"
                        : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.descricao!,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
