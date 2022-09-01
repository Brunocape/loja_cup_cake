import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/services/constantes.dart';
import 'package:loja_cup_cake/services/pref_service.dart';

class Usuario_Controller {
  final String _url = Constantes.GetUrl();

  Future<UsuarioModel> GetUserLogado() async {
    PreferenceService pser = PreferenceService();
    String user_id = await pser.GetUserId();
    //String token = await pser.GetToken();
    var url = Uri.parse(_url + 'usuario/BuscarPorId');

    try {
      var response = await http.post(
        url,
        //headers: {'Authorization': 'Bearer ' + token},
        body: {'idUsuario': user_id},
      );
      var data = json.decode(response.body);
      return UsuarioModel.fromJson(data["dados"]);
    } catch (Erro) {
      return UsuarioModel();
    }
  }

  Future<Map<String, dynamic>> SendEmail(String email) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'usuario/EnviarEmail');
    try {
      var response = await http.post(
        url,
        body: {'emailUsuario': email},
      );
      var data = json.decode(response.body);
      retorno["mensagem"] = data["mensagem"];
      retorno["status"] = data["status"];
      return retorno;

    } catch (Erro) {
      Map<String, dynamic> retorno = {
        "status": "Erro",
        "mensagem": "falha ao conectar ao servidor"
      };
      return retorno;
    }
  }

  Future<Map<String, dynamic>> Ativa(String email, String codigo) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'usuario/AtivarUsuario');
    try {
      var response = await http.post(
        url,
        body: {
          'emailUsuario': email,
          'codigo_validUsuario' : codigo,
        },
      );
      var data = json.decode(response.body);
      retorno["mensagem"] = data["mensagem"];
      retorno["status"] = data["status"];
      return retorno;

    } catch (Erro) {
      Map<String, dynamic> retorno = {
        "status": "Erro",
        "mensagem": "falha ao conectar ao servidor"
      };
      return retorno;
    }
  }



  Future<Map<String, dynamic>> AlterarSenha(String email, String codigo, String senha) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'usuario/AlterarSenha');
    try {
      var response = await http.post(
        url,
        body: {
          'emailUsuario': email,
          'codigo_validUsuario' : codigo,
          'senhaUsuario' : senha
        },
      );
      var data = json.decode(response.body);
      retorno["mensagem"] = data["mensagem"];
      retorno["status"] = data["status"];
      return retorno;

    } catch (Erro) {
      Map<String, dynamic> retorno = {
        "status": "Erro",
        "mensagem": "falha ao conectar ao servidor"
      };
      return retorno;
    }
  }

  Future<Map<String, dynamic>> logar(
      {String email = "", String senha = ""}) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'usuario/logar');
    try {
      var response = await http.post(
        url,
        //headers: {'Authorization': 'Bearer ' + user.ultimoLog.token_api},
        body: {'emailUsuario': email.toUpperCase(), 'senhaUsuario': senha},
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["status"] == "Ok") {
          retorno["user"] = UsuarioModel.fromJson(data["user"]);
          PreferenceService pref = PreferenceService();
          pref.SetPreference(
              retorno["user"].token, true, retorno["user"].id.toString());
        }
      }
      retorno["mensagem"] = data["mensagem"];
      retorno["status"] = data["status"];

      return retorno;
    } catch (erro) {
      Map<String, dynamic> retorno = {
        "status": "Erro",
        "mensagem": erro.toString()
      };
      return retorno;
    }
  }

  Future<void> signOut() async {
    PreferenceService pref = PreferenceService();
    pref.RemovePreference();
  }

  Future<Map<String, dynamic>> Cadastrar(
      {String email = "", String senha = "", String nome = ""}) async {
    Map<String, dynamic> retorno = {};
    var url = Uri.parse(_url + 'cadastrar');
    try {
      var response = await http.post(
        url,
        //headers: {'Authorization': 'Bearer ' + user.ultimoLog.token_api},
        body: {
          'senhaUsuario': senha,
          'emailUsuario': email.toUpperCase(),
          'nomeUsuario': nome.toUpperCase()
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200 && data["status"] == "Ok") {
        retorno["user"] = UsuarioModel.fromJson(data["user"]);
        PreferenceService pref = PreferenceService();
        pref.SetPreference(retorno["user"].token!, true, retorno["user"].id!);
      }
      retorno["status"] = data["status"];
      retorno["mensagem"] = data["mensagem"];
      return retorno;
    } catch (erro) {
      Map<String, dynamic> retorno = {
        "status": "Erro",
        "mensagem": erro.toString()
      };
      return retorno;
    }
  }
}
