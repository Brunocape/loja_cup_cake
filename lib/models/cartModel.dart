import 'dart:async';

import 'package:loja_cup_cake/controllers/cartController.dart';
import 'package:loja_cup_cake/controllers/pedidoController.dart';
import 'package:loja_cup_cake/models/itemCartModel.dart';
import 'package:loja_cup_cake/models/pedidoModel.dart';

class CartModel {
  List<ItemCartModel> products = [];

  String couponCode = '';
  int discountPercentage = 0;

  Future<Map<String, dynamic>> addCartItem(ItemCartModel itemCartModel) async {
    CartController cc = CartController();
    Map<String, dynamic> retorno = await cc.Cadastrar(itemCartModel);
    await loadCartItems(itemCartModel.usuarioId!);
    return retorno;
  }

  Future<Map<String, dynamic>> updateCartItem(
      ItemCartModel itemCartModel) async {
    CartController cc = CartController();
    return await cc.Atualizar(itemCartModel);
  }

  Future<Map<String, dynamic>> removeCartItem(
      ItemCartModel itemCartModel) async {
    CartController cc = CartController();
    products.remove(itemCartModel);
    return await cc.Apagar(itemCartModel);
  }

  Future<Map<String, dynamic>> setCoupon(String couponCode) async {
    CartController cartController = CartController();
    var response = await cartController.GetCupon(couponCode);
    if (response["status"] == "Ok") {
      this.couponCode = response["dados"]["descricao"] ?? "";
      discountPercentage = response["dados"]["percentual"] ?? 0;
    } else {
      this.couponCode = "";
      discountPercentage = 0;
    }
    return response;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (ItemCartModel c in products) {
      if (c.item != null) {
        price += c.qtde! * double.parse(c.item!.perco!);
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  Future<Map<String, dynamic>> finishOrder() async {
    Map<String, dynamic> retorno = {};

    if (products.length == 0) {
      retorno["status"] = "Erro";
      retorno["mensagem"] = "pedido sem produtos";
      return retorno;
    }

    PedidoModel pedidoModel = PedidoModel.fromCartModel(this);
    PedidoController pedidoController = PedidoController();
    retorno = await pedidoController.Salvar(pedidoModel);
    if (retorno['status'] == "Ok") {
      CartController cartController = CartController();
      products.forEach((item) async {
        await cartController.Apagar(item);
      });
      products.clear();
      couponCode = "";
      discountPercentage = 0;
    }
    return retorno;
  }

  Future<void> loadCartItems(int userId) async {
    CartController cc = CartController();
    this.products = await cc.LoadItens(userId);
  }
}
