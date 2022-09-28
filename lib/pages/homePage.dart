import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/loginPage.dart';
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
  CartModel? cartModel;
  _HomePageState(this.user);

  @override
  void initState() {
    Usuario_Controller uc = Usuario_Controller();
    uc.GetUserLogado().then((value) {
      this.user = value;
      cartModel?.loadCartItems(user.id!).then((value) => {setState(() {})});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Pit - Bruno Capelario Santos"),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    if (!user.isLoggedIn()) {
                      var usuario1 = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      setState(() {
                        user = usuario1 ?? UsuarioModel();
                      });
                    } else {
                      setState(() {
                        user = UsuarioModel();
                        Usuario_Controller uc = Usuario_Controller();
                        uc.signOut();
                      });
                    }
                  },
                  child: Text(
                    !user.isLoggedIn() ? "Faça login" : "Sair",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController, user),
          floatingActionButton: CartButton(user),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
          ),
          body: CategoryTab(cartModel ?? CartModel(), user),
          drawer: CustomDrawer(_pageController, user),
          floatingActionButton: CartButton(user),
        ),
        Scaffold(
          body: Container(
            color: Colors.yellow,
          ),
          drawer: CustomDrawer(_pageController, user),
        ),
        Scaffold(
          body: Container(
            color: Colors.green,
          ),
          drawer: CustomDrawer(_pageController, user),
        )
      ],
    );
  }
}
