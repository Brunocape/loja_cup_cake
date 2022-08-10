import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  late String id;
  late String category;
  late String title;
  late double price;
  late List images;


  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.get("title");
    price = snapshot.get("price") + 0.0;
    images = snapshot.get("images");
    category = "";
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "price": price
    };
  }

}