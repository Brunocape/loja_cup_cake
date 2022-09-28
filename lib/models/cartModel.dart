import 'dart:async';

import 'package:loja_cup_cake/controllers/cartController.dart';
import 'package:loja_cup_cake/models/itemCartModel.dart';

class CartModel  {

  List<ItemCartModel> products = [];

  String couponCode = '';
  int discountPercentage = 0;

  bool isLoading = false;

  Future<Map<String,dynamic>> addCartItem(ItemCartModel itemCartModel) async{
    CartController cc = CartController();
    Map<String,dynamic> retorno =  await cc.Cadastrar(itemCartModel);
    await loadCartItems(itemCartModel.usuarioId!);
    return retorno;
  }

  Future<Map<String,dynamic>> updateCartItem(ItemCartModel itemCartModel) async{
    CartController cc = CartController();
    return  await cc.Atualizar(itemCartModel);
  }

  Future<Map<String,dynamic>> removeCartItem(ItemCartModel itemCartModel) async{
    CartController cc = CartController();
    products.remove(itemCartModel);
    return  await cc.Apagar(itemCartModel);

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

  Future<void> loadCartItems(int userId) async {
    CartController cc = CartController();
    this.products = await cc.LoadItens(userId);
  }

}
