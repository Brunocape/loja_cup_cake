import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/tabs/categoryTab.dart';
import 'package:loja_cup_cake/tabs/homeTab.dart';
import 'package:loja_cup_cake/widgets/cart_button.dart';
import 'package:loja_cup_cake/widgets/customDrawer.dart';

class HomePage extends StatefulWidget {
  final UsuarioModel user;

  HomePage(this.user);

  @override
  State<HomePage> createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  UsuarioModel user;
  _HomePageState(this.user);

  @override
  void initState(){
    Usuario_Controller uc = Usuario_Controller();
    uc.GetUserLogado().then((value){
      setState(() {
        this.user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics:const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController,user),
          floatingActionButton: CartButton(user),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
          ),
          body: CategoryTab(),
          drawer: CustomDrawer(_pageController,user),
          floatingActionButton: CartButton(user),
        ),
        Scaffold(
          body: Container(color: Colors.yellow,),
          drawer: CustomDrawer(_pageController,user),
        ),
        Scaffold(
          body: Container(color: Colors.green,),
          drawer: CustomDrawer(_pageController,user),
        )
      ],
    );
  }
}


