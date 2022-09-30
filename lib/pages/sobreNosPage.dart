import 'package:flutter/material.dart';

class SobreNosPage extends StatelessWidget {
  const SobreNosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const[
                Text("Nome: Bruno Capelario santos", style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(),
            Row(
              children: const[
                Text("RGM: 21507376", style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(),
            Row(
              children: const[
                Text("Instituição: Cruzeiro do Sul (Unifram)", style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(),
            Row(
              children: const[
                Text("email: brunocapelario@gmail.com", style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(),
            Row(
              children: const[
                Text("PIT - ultimo semestre engenharia de software", style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(),
          ],
        ),
      );
  }
}
