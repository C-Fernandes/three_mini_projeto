import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_mini_projeto/model/pais.dart';
import 'package:three_mini_projeto/components/item_lugar.dart';
import 'package:three_mini_projeto/providers/lugar_provider.dart';

class LugarPorPaisScreen extends StatelessWidget {
  const LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pais = ModalRoute.of(context)?.settings.arguments as Pais;
    
    // Usar o LugarProvider para pegar os lugares por país
    final lugaresPorPais = Provider.of<LugarProvider>(context)
        .getLugaresPorPais(pais); // Método corrigido para filtrar corretamente

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: lugaresPorPais.isEmpty
          ? Center(child: Text('Não há lugares para esse país.'))
          : ListView.builder(
              itemCount: lugaresPorPais.length,
              itemBuilder: (context, index) {
                return ItemLugar(lugar: lugaresPorPais[index]);
              },
            ),
    );
  }
}
