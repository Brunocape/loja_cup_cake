import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/categoriaController.dart';
import 'package:loja_cup_cake/models/categoriaModel.dart';
import 'package:loja_cup_cake/tiles/categoryTile.dart';
class CategoryTab extends StatelessWidget {

  Categoria_Controller categoria_controller = Categoria_Controller();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categoria>>(
        future: categoria_controller.GetCategorias(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
           }else{
            return ListView(
              children: snapshot.data!.map(
               (doc){
                  return CategoryTile(doc);
            }).toList(),
            );
          }
        });
  }
}
