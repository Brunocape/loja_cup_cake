import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/productData.dart';
import 'package:loja_cup_cake/tiles/productTile.dart';
class CategoryPage extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.get("title")),
            centerTitle: true,
            bottom:const TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on),),
                Tab(icon: Icon(Icons.list),)
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("categorias").doc(snapshot.id)
                  .collection("Itens").get(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator(),);
                else
                  // ignore: curly_braces_in_flow_control_structures
                  return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                            padding:const  EdgeInsets.all(4.0),
                            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index){
                              ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                              data.category = this.snapshot.id;
                              return ProductTile("grid", data);
                            }
                        ),
                        ListView.builder(
                            padding: EdgeInsets.all(4.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index){
                              ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                              data.category = this.snapshot.id;
                              return ProductTile("list", data);
                            }
                        )
                      ]
                  );
              }
          )
      ),
    );
  }
}