import 'package:flutter/material.dart';
import 'package:loja_cup_cake/tabs/categoryTab.dart';
import 'package:loja_cup_cake/tabs/homeTab.dart';
import 'package:loja_cup_cake/widgets/customDrawer.dart';

class HomePage extends StatelessWidget {
final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics:const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
          ),
          body: CategoryTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          body: Container(color: Colors.yellow,),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          body: Container(color: Colors.green,),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}

