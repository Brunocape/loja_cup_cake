import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_cup_cake/controllers/imageHomeController.dart';
import 'package:loja_cup_cake/models/imagemHomeModel.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override

  ImageHomeController ic = ImageHomeController();

  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            FutureBuilder<List<ImagemHome>>(
              future: ic.GetImagens() ,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: snapshot.data!.map(( doc) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: doc.posX!,
                          mainAxisCellCount: doc.posY!,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc.url!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
