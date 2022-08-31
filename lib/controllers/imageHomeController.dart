import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/imagemHomeModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';

class ImageHomeController{
  final String _url = Constantes.GetUrl();

  Future<List<ImagemHome>> GetImagens()async {

    List<ImagemHome> imagens = [];
    var url = Uri.parse(_url + 'imageHome/buscarTodos');
    try {
      var response = await http.post(
        url
      );
      var data = json.decode(response.body);
      data["imagens_home"].forEach((img){
        imagens.add(ImagemHome.fromJson(img));
      });
      return imagens;
    } catch(Erro) {
      return imagens;
    }
  }

}