// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/homePage.dart';
import 'package:loja_cup_cake/pages/signUpPage.dart';
import 'package:loja_cup_cake/pages/validarCodigoPage.dart';
import 'package:loja_cup_cake/services/loadAndToast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioModel usuario = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15.0),
            ),
            onPressed: () async {
              usuario = await Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage()));
              if(usuario.ativo == 0 && usuario.id != 0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ValidaarCodigoPage(false, usuario.email!),));
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty || !text.contains("@"))
                  return "E-mail inválido!";
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _passController,
              decoration: const InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text!.isEmpty) {
                  return "Senha inválida!";
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Insira seu e-mail para recuperação!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    Usuario_Controller uc = Usuario_Controller();
                    LoadAndToast lt = LoadAndToast();
                    lt.showLoaderDialog(context, "Estamos enviando o email");
                    var retorno = await uc.SendEmail(_emailController.text);
                    Navigator.pop(context);
                    if(retorno["status"]== "Erro"){

                      lt.showToast(context, retorno["mensagem"]);
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ValidaarCodigoPage(true, _emailController.text),));
                    }
                  }
                },
                child: const Text(
                  "Esqueci minha senha",
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // ignore: use_build_context_synchronously
                    LoadAndToast lt = LoadAndToast();
                    lt.showLoaderDialog(context, "Aguarde.....");
                    Usuario_Controller us = Usuario_Controller();
                    var response = await us.logar(
                        email: _emailController.text,
                        senha: _passController.text);
                    if (response["status"] == "Ok") {
                      usuario = response["user"];
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(usuario),));
                    } else {
                      if(response["mensagem"] == "Este usuario não esta ativo"){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ValidaarCodigoPage(false, _emailController.text),));
                      }else{
                        Navigator.pop(context);
                        lt.showToast(context, response["mensagem"]);
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
