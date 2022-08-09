import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_cup_cake/tiles/categoryTile.dart';
class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future:FirebaseFirestore.instance.collection("categorias").get() ,
        builder: (context, snapshot){
          if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
           }else{
            return ListView(
              children: snapshot.data!.docs.map(
               (doc){
                  return CategoryTile(doc);
            }).toList(),
            );
          }
        });
  }
}
