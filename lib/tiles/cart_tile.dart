import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/itemCartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/cartPage.dart';


class CartTile extends StatefulWidget {
  final ItemCartModel itemCartModel;
  final CartModel cartModel;
  final UsuarioModel user;


  CartTile(this.cartModel, this.itemCartModel, this.user);

  @override
  State<CartTile> createState() => _CartTileState(cartModel, itemCartModel, this.user);
}

class _CartTileState extends State<CartTile> {
  final ItemCartModel itemCartModel;
  final CartModel cartModel;
  final UsuarioModel user;

  _CartTileState(this.cartModel,this.itemCartModel, this.user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(
            itemCartModel.item!.imagens![0].path!,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  itemCartModel.item!.descricao!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                // Text(
                //   "Tamanho: ${cartProduct.size}",
                //   style: TextStyle(fontWeight: FontWeight.w300),
                // ),
                Text(
                  "R\$ ${itemCartModel.item!.perco!.toString()}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                      onPressed: itemCartModel.qtde! > 1 ?
                          (){
                        setState(()=>{
                          itemCartModel.decProduct(),
                        });
                      } : null,
                    ),
                    Text(itemCartModel.qtde.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        setState(()=>{
                          itemCartModel.incProduct(),
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text("Remover"),
                      onPressed: (){
                        cartModel.removeCartItem(itemCartModel).then((value) => {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartPage(cartModel, user),))
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}


