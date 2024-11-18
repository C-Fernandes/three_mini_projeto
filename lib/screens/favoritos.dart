import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_mini_projeto/providers/favoritos_provider.dart';
import 'package:three_mini_projeto/components/item_lugar.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lugaresFavoritos = context.watch<FavoritosProvider>().lugaresFavoritos;

    if (lugaresFavoritos.isEmpty) {
      return const Center(
        child: Text('Nenhum Lugar Marcado como Favorito!', style: TextStyle(fontSize: 20)),
      );
    } else {
      return ListView.builder(
        itemCount: lugaresFavoritos.length,
        itemBuilder: (ctx, index) {
          return ItemLugar(lugar: lugaresFavoritos.elementAt(index));
        },
      );
    }
  }
}
