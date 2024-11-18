import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:three_mini_projeto/screens/gerenciar_paises.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ThemeData().primaryColor,
            ),
            child: const Text(
              'Configurações',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Países'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/'); // Usando rota nomeada
            },
          ),
          ListTile(
            leading: const Icon(Icons.engineering),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  '/configuracoes'); // Usando rota nomeada
            },
          ),
          // Novo item de menu para a tela de cadastro de lugar
          ListTile(
            leading: const Icon(Icons.location_on), // Ícone para o lugar
            title: const Text('Adicionar Lugar'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/cadastro_lugar'); // Usando rota nomeada
            },
          ),
          ListTile(
            leading: const Icon(Icons.manage_search), // Ícone de gerenciamento
            title: const Text('Gerenciar Lugares'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/gerenciar_lugares'); // Rota para a nova tela
            },
          ),

          ListTile(
            leading: const Icon(Icons.map), // Ícone para "Gerenciar Países"
            title: const Text('Gerenciar Países'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => GerenciarPaisesScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
