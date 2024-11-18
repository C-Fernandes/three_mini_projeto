import 'package:provider/provider.dart';
import 'package:three_mini_projeto/components/item_pais.dart';
import 'package:three_mini_projeto/data/dados.dart';
import 'package:flutter/material.dart';
import 'package:three_mini_projeto/providers/pais_provider.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  // Método para acessar os países do Provider
  List<Widget> getPaises(PaisProvider paisProvider) {
    return paisProvider.paisesProvider
        .map((pais) => ItemPais(pais: pais))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PaisProvider>(
        builder: (context, paisProvider, child) {
          return GridView(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 120,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
            ),
            children: getPaises(paisProvider),
          );
        },
      ),
    );
  }
}
