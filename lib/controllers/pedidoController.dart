import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/pedidoModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';
class PedidoController{
  final String _url = Constantes.GetUrl();

  Future<List<PedidoModel>> LoadPedidos(int userId) async {
    List<PedidoModel> retorno = [];
    var url = Uri.parse(_url + 'Pedido/buscarPorClienteId');
    try {
      var response =
      await http.post(url, body: {"idUsuario": userId.toString()});
      var data = json.decode(response.body);
      var pedidos = data["dados"];
      pedidos.forEach((pedido) {
        retorno.add(PedidoModel.fromJson(pedido));
      });
      return retorno;
    } catch (Erro) {
      return retorno;
    }
  }

  Future<Map<String, dynamic>> Salvar(PedidoModel pedido) async {
    var url = Uri.parse(_url + 'Pedido/cadastrar');
    var pedidoJson = jsonEncode(pedido);
    try {
      var response =
      await http.post(url, 
          body: {"pedido": pedidoJson}
      );
      return json.decode(response.body);
    } catch (Erro) {
      Map<String, dynamic> retorno = {};
      return retorno;
    }
  }

}