
import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/services/loadAndToast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Nome Completo"),
                validator: (text) {
                  if (text!.isEmpty) return "Nome Inválido!";
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text!.isEmpty || !text.contains("@"))
                    return "E-mail inválido!";
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text!.isEmpty) return "Senha inválida!";
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 44.0,
                child: ElevatedButton(
                  child: const Text(
                    "Criar Conta",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      LoadAndToast lt = LoadAndToast();
                      lt.showLoaderDialog(context, "Aguarde....");
                      Usuario_Controller us = Usuario_Controller();
                      var response =  await us.Cadastrar(
                          email: _emailController.text,
                          senha: _passController.text,
                          nome: _nameController.text
                      );
                      Navigator.pop(context);
                      Navigator.pop(context, response["user"]);
                      lt.showToast(context,response["mensagem"]);
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
