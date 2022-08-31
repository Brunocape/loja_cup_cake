import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/categoriaModel.dart';
import 'package:loja_cup_cake/pages/categoryPage.dart';

class CategoryTile extends StatelessWidget {
  final Categoria categoria;

  CategoryTile(this.categoria);

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
            MaterialPageRoute(builder: (context)=>CategoryPage(categoria))
        );
      },
    );
  }
}
