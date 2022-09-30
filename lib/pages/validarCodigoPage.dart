import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/services/loadAndToast.dart';
class ValidaarCodigoPage extends StatelessWidget {
  ValidaarCodigoPage( this.alterarSenha,this.email);
  bool alterarSenha;
  String email;

  final _codigoController = TextEditingController();
  final _alterarSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validar Código"),
        centerTitle: true,
      ),
      body:  Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(15.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                   Text("Informe o código enviado em seu email.",style: TextStyle(fontSize: 18),),
                  TextFormField(
                    controller: _codigoController,
                    decoration: const InputDecoration(hintText: "Codigo"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text!.isEmpty)
                        return "Codigo inválido!";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Visibility(
                      visible: alterarSenha,
                      child: Column(
                        children: [
                           Text("Informe a nova senha",style: TextStyle(fontSize: 18),),
                          TextFormField(
                            controller: _alterarSenhaController,
                            decoration: const InputDecoration(hintText: "Senha"),
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text!.isEmpty || text.length < 6)
                                return "Senha inválida!";
                              return null;
                            },
                          ),
                        ],
                      )
                  ),

                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      child: const Text(
                        "Enviar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () async {
                        if(alterarSenha){
                          if (_formKey.currentState!.validate()) {
                            LoadAndToast lt = LoadAndToast();
                            lt.showLoaderDialog(context, "Aguarde.....");
                            Usuario_Controller us = Usuario_Controller();
                            var retorno = await us.AlterarSenha(email, _codigoController.text, _alterarSenhaController.text);
                            Navigator.pop(context);
                            if (retorno["status"] == "Ok") {
                              Navigator.pop(context);
                              lt.showToast(context, retorno["mensagem"]);
                            } else {
                              lt.showToast(context, retorno["mensagem"]);
                            }
                          }
                        }else{
                          LoadAndToast lt = LoadAndToast();
                          lt.showLoaderDialog(context, "Aguarde.....");
                          Usuario_Controller us = Usuario_Controller();
                          var retorno = await us.Ativar(email, _codigoController.text);
                          Navigator.pop(context);
                          if (retorno["status"] == "Ok") {
                            Navigator.pop(context);
                            lt.showToast(context, retorno["mensagem"]);
                          } else {
                            lt.showToast(context, retorno["mensagem"]);
                          }
                        }

                      },
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
