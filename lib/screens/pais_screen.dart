import 'package:three_mini_projeto/components/item_pais.dart';
import 'package:three_mini_projeto/data/dados.dart';
import 'package:flutter/material.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});


  List<Widget> getPaises() {
    return paises.map((pais) => ItemPais(pais: pais)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Países",
          style: TextStyle(color: Colors.white),
        ),
      ), */
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 120,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          
        ),
        children: getPaises(),
      ),
    );
  }
}
