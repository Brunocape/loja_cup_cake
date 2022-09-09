import 'dart:async';

import 'package:loja_cup_cake/models/itemCartModel.dart';
import 'package:loja_cup_cake/models/itemModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:flutter/material.dart';

class CartModel  {

  UsuarioModel user;

  List<ItemCartModel> products = [];

  String couponCode = '';
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }


  void addCartItem(ItemCartModel itemCartModel){
    //salvar item no banco de dados
    products.add(itemCartModel);

  }

  void removeCartItem(ItemCartModel itemCartModel){

    //remover item no banco de dados
    products.remove(itemCartModel);

  }

  void decProduct(ItemCartModel itemCartModel){
    itemCartModel.qtde = (itemCartModel.qtde ?? 1) - 1;
    //atualizar no banco de dados

 }

  void incProduct(ItemCartModel itemCartModel){
    itemCartModel.qtde = (itemCartModel.qtde ?? 1) + 1;
    //atualizar no banco de dados

  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }


  double getProductsPrice(){
    double price = 0.0;
    for(ItemCartModel c in products){
      if(c.item != null) {
        price += c.qtde! * double.parse(c.item!.perco!);
      }
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice(){
    return 9.99;
  }

  Future<String> finishOrder() async {
    if(products.length == 0)
      return "";

    isLoading = true;

    return "";

    // double productsPrice = getProductsPrice();
    // double shipPrice = getShipPrice();
    // double discount = getDiscount();

    // DocumentReference refOrder = await Firestore.instance.collection("orders").add(
    //   {
    //     "clientId": user.firebaseUser.uid,
    //     "products": products.map((cartProduct)=>cartProduct.toMap()).toList(),
    //     "shipPrice": shipPrice,
    //     "productsPrice": productsPrice,
    //     "discount": discount,
    //     "totalPrice": productsPrice - discount + shipPrice,
    //     "status": 1
    //   }
    // );
    //
    // await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    //   .collection("orders").document(refOrder.documentID).setData(
    //   {
    //     "orderId": refOrder.documentID
    //   }
    // );
    //
    // QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    //   .collection("cart").getDocuments();
    //
    // for(DocumentSnapshot doc in query.documents){
    //   doc.reference.delete();
    // }
    //
    // products.clear();
    //
    // couponCode = null;
    // discountPercentage = 0;
    //
    // isLoading = false;
    // notifyListeners();
    //
    // return refOrder.documentID;
  }

  void _loadCartItems() async {



  }

}









