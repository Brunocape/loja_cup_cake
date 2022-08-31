import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/itemModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';
//import 'package:loja_cup_cake/services/pref_service.dart';

class Item_Controller {
  final String _url = Constantes.GetUrl();

  Future<List<Item>> GetItensByCat(int Cartegoria_id) async {
    List<Item> itens = [];
    var url = Uri.parse(_url + "item/buscarPorCat");

    try {
      var response = await http.post(
        url,
        body: {'categoria_idItem': Cartegoria_id.toString()},
      );
      if(response.statusCode == 200){
        var data = json.decode(response.body);

        data['Itens'].forEach((item) {
          itens.add(Item.fromJson(item));
        });
      }

      return itens;
    } catch (Erro) {
      return itens;
    }
  }
}
