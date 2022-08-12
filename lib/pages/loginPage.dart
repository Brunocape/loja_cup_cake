import 'package:flutter/material.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/signUpPage.dart';
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

  UserModel model = UserModel();

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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpPage()));
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
                onPressed: () {
                  if (_emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Insira seu e-mail para recuperação!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    model.recoverPass(_emailController.text);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Confira seu e-mail!"),
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(seconds: 2),
                    ));
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
                  if (_formKey.currentState!.validate()) {}

                  // ignore: use_build_context_synchronously
                  LoadAndToast lt = LoadAndToast();

                  lt.showToast(
                      context,
                      await model.signIn(
                          email: _emailController.text,
                          pass: _passController.text));
                  Navigator.pop(context, model);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
