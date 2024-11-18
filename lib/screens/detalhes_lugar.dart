import 'package:three_mini_projeto/model/lugar.dart';
import 'package:flutter/material.dart';
import 'package:three_mini_projeto/providers/favoritos_provider.dart'; 
import 'package:provider/provider.dart';

class DetalhesLugarScreen extends StatelessWidget {
  const DetalhesLugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o objeto Lugar da navegação
    final lugar = ModalRoute.of(context)?.settings.arguments as Lugar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          lugar.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Imagem do lugar
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              lugar.imagemUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Título das dicas
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: ThemeData().textTheme.displayLarge,
            ),
          ),
          // Lista de recomendações
          Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
                itemCount: lugar.recomendacoes.length,
                itemBuilder: (contexto, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(lugar.recomendacoes[index]),
                        subtitle: Text(lugar.titulo),
                        onTap: () {
                          print(lugar.recomendacoes[index]);
                        },
                      ),
                      Divider(),
                    ],
                  );
                }),
          ),
        ],
      ),
      // Floating Action Button para favoritar
      floatingActionButton: Consumer<FavoritosProvider>(
        builder: (context, favoritosProvider, child) {
          final isFavorito = favoritosProvider.isFavorito(lugar);

          return FloatingActionButton(
            onPressed: () {
              favoritosProvider.toggleFavorito(lugar); // Chamando o método do Provider
            },
            child: Icon(
              isFavorito ? Icons.star : Icons.star_border,
            ),
          );
        },
      ),
    );
  }
}
