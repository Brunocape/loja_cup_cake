import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/categoriaModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';

//import 'package:loja_cup_cake/services/pref_service.dart';
class Categoria_Controller {
  final String _url = Constantes.GetUrl();

  Future<List<Categoria>> GetCategorias() async {
    List<Categoria> categorias = [];
    var url = Uri.parse(_url + 'categoria/buscarTodos');
    try {
      var response = await http.post(url);
      var data = json.decode(response.body);
      data["Categorias"].forEach((cat) {
        categorias.add(Categoria.fromJson(cat));
      });
      return categorias;
    } catch (Erro) {
      return categorias;
    }
  }
}
