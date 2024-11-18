import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_mini_projeto/model/pais.dart';
import 'package:three_mini_projeto/providers/pais_provider.dart';

class GerenciarPaisesScreen extends StatelessWidget {
  const GerenciarPaisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paisProvider = Provider.of<PaisProvider>(context);
    final paises = paisProvider.paisesProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Países'),
      ),
      body: ListView.builder(
        itemCount: paises.length,
        itemBuilder: (ctx, index) {
          final pais = paises[index];

          return ListTile(
            title: Text(pais.titulo), // Mostra o nome do país
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícone para editar
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _abrirModalEdicao(context, pais);
                  },
                ),
                // Ícone para remover
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _confirmarRemocao(context, pais, paisProvider);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirModalCadastro(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Modal para editar um país
  void _abrirModalEdicao(BuildContext context, Pais pais) {
    final nomeController = TextEditingController(text: pais.titulo);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Editar País'),
          content: TextField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome do País'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final paisAtualizado = Pais(
                  id: pais.id, // Mantém o mesmo ID
                  titulo: nomeController.text, // Novo nome
                  cor: pais.cor, // Mantém a cor
                );

                Provider.of<PaisProvider>(context, listen: false)
                    .editarPais(pais.id, paisAtualizado);

                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Modal para cadastrar um novo país
  void _abrirModalCadastro(BuildContext context) {
    final nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Cadastrar País'),
          content: TextField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome do País'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final novoPais = Pais(
                  id: DateTime.now().toString(), // Gera um ID único para o país
                  titulo: nomeController.text,
                  cor: Colors.blue, // Cor padrão
                );

                Provider.of<PaisProvider>(context, listen: false)
                    .adicionarPais(novoPais);

                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para confirmar a remoção de um país
  void _confirmarRemocao(
      BuildContext context, Pais pais, PaisProvider paisProvider) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Confirmar Remoção'),
          content: Text('Você realmente deseja remover este país?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                paisProvider.removerPais(pais);
                Navigator.of(ctx).pop(); // Fecha o modal
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('País removido com sucesso!')),
                );
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }
}
