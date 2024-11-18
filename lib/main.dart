import 'package:provider/provider.dart';
import 'package:three_mini_projeto/model/lugar.dart';
import 'package:three_mini_projeto/providers/favoritos_provider.dart';
import 'package:three_mini_projeto/providers/lugar_provider.dart';
import 'package:three_mini_projeto/providers/pais_provider.dart';
import 'package:three_mini_projeto/screens/abas.dart';
import 'package:three_mini_projeto/screens/cadastro_lugar.dart';
import 'package:three_mini_projeto/screens/configuracoes.dart';
import 'package:three_mini_projeto/screens/detalhes_lugar.dart';
import 'package:three_mini_projeto/screens/gerenciar_lugares.dart';
import 'package:three_mini_projeto/screens/gerenciar_paises.dart';
import 'package:three_mini_projeto/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritosProvider()),
        ChangeNotifierProvider(create: (context) => LugarProvider()),
        ChangeNotifierProvider(create: (context) => PaisProvider()),
      ],
      child: MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("iniciando app");
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MinhasAbas(),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => const DetalhesLugarScreen(),
        '/configuracoes': (ctx) => const ConfigracoesScreen(),
        '/cadastro_lugar': (ctx) => const CadastroLugarScreen(),
        '/gerenciar_lugares': (ctx) => const GerenciarLugaresScreen(),
        '/gerenciar_paises': (ctx) => const GerenciarPaisesScreen(),
      },
    );
  }
}
