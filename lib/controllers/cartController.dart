import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/itemCartModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';

class CartController {
  final String _url = Constantes.GetUrl();

  Future<List<ItemCartModel>> LoadItens(int userId) async {
    List<ItemCartModel> retorno = [];
    var url = Uri.parse(_url + 'ItemCarinho/buscarPorUserId');
    try {
      var response =
          await http.post(url, body: {"idUsuario": userId.toString()});
      var data = json.decode(response.body);
      var itens = data["itens_carinho"];
      itens.forEach((itemcart) {
        retorno.add(ItemCartModel.fromJson(itemcart));
      });
      return retorno;
    } catch (Erro) {
      return retorno;
    }
  }

  Future<Map<String, dynamic>> GetCupon(String desc) async {
    var url = Uri.parse(_url + 'cupom/buscarPorDesc');
    try {
      var response = await http.post(url, body: {"descricaoCupom": desc});
      var data = json.decode(response.body);
      return data;
    } catch (Erro) {
      return {};
    }
  }

  Future<Map<String, dynamic>> Cadastrar(ItemCartModel itemCartModel) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'ItemCarinho/cadastrar');
    try {
      var response = await http.post(url, body: {
        "usuario_idItemCarinho": itemCartModel.usuarioId.toString(),
        "item_idItemCarinho": itemCartModel.itemId.toString(),
        "qtdeItemCarinho": itemCartModel.qtde.toString()
      });
      retorno = json.decode(response.body);
      return retorno;
    } catch (Erro) {
      return retorno;
    }
  }

  Future<Map<String, dynamic>> Atualizar(ItemCartModel itemCartModel) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'ItemCarinho/atualizar');
    try {
      var response = await http.post(url, body: {
        "usuario_idItemCarinho": itemCartModel.usuarioId.toString(),
        "item_idItemCarinho": itemCartModel.itemId.toString(),
        "qtdeItemCarinho": itemCartModel.qtde.toString(),
        "idItemCarinho": itemCartModel.id.toString()
      });
      retorno = json.decode(response.body);
      return retorno;
    } catch (Erro) {
      return retorno;
    }
  }

  Future<Map<String, dynamic>> Apagar(ItemCartModel itemCartModel) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'ItemCarinho/apagar');
    try {
      var response = await http
          .post(url, body: {"idItemCarinho": itemCartModel.id.toString()});
      retorno = json.decode(response.body);
      return retorno;
    } catch (Erro) {
      return retorno;
    }
  }
}
