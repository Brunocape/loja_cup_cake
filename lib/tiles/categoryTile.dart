import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/categoriaModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/categoryPage.dart';

class CategoryTile extends StatelessWidget {
  final Categoria categoria;
  UsuarioModel user;
  CartModel cartModel;

  CategoryTile(this.categoria,this.cartModel, this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(categoria.icon!),
        ),
      title: Text("${categoria.descricao} "   " ${categoria.peso.toString()}Gr"),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>CategoryPage(categoria,cartModel, user))
        );
      },
    );
  }
}
