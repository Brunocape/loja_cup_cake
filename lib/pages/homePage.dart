import 'package:flutter/material.dart';
import 'package:loja_cup_cake/controllers/usuarioController.dart';
import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/pedidoModel.dart';
import 'package:loja_cup_cake/models/userModel.dart';
import 'package:loja_cup_cake/pages/loginPage.dart';
import 'package:loja_cup_cake/pages/meusPedidosPage.dart';
import 'package:loja_cup_cake/pages/sobreNosPage.dart';
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
      if(this.user.id == null){
        this.user = value;
      }
      setState(() {});
      cartModel?.loadCartItems(user.id!);
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
                  onPressed: ()  {
                    if (!user.isLoggedIn()) {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    } else {
                      setState(() {
                        user = UsuarioModel();
                        Usuario_Controller uc = Usuario_Controller();
                        uc.signOut();
                      });
                    }
                  },
                  child: Text(
                    !user.isLoggedIn() ? "Fa??a login" : "Sair",
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
          appBar: AppBar(
            title: Text("Meus Pedidos"),
          ),
          body: MeusPedidosPage(user),
          drawer: CustomDrawer(_pageController, user),
        ),
        Scaffold(
          appBar: AppBar(
            title:const Text("Quem Somos?", style: TextStyle(fontSize: 18, color: Colors.white),),
          ),
          body: SobreNosPage(),
          drawer: CustomDrawer(_pageController, user),
        ),
      ],
    );
  }
}

