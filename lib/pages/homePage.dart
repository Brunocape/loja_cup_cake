import 'package:flutter/material.dart';
import 'package:loja_cup_cake/tabs/homeTab.dart';

class HomePage extends StatelessWidget {
final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics:const NeverScrollableScrollPhysics(),
      children: [
        HomeTab(),
      ],
    );
  }
}

