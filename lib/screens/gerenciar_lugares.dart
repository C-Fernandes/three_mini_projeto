import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_mini_projeto/model/lugar.dart';
import 'package:three_mini_projeto/providers/lugar_provider.dart';

class GerenciarLugaresScreen extends StatelessWidget {
  const GerenciarLugaresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aqui, usamos o contexto para acessar o LugarProvider
    final lugarProvider = Provider.of<LugarProvider>(context);
    final lugares = lugarProvider.lugaresProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
      ),
      body: ListView.builder(
        itemCount: lugares.length,
        itemBuilder: (ctx, index) {
          final lugar = lugares[index];

          return ListTile(
            title: Text(lugar.titulo), // Mostra o título do lugar
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícone para editar
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Abre o modal para editar
                    _abrirModalEdicao(context, lugar);
                  },
                ),
                // Ícone para remover
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Confirma a remoção
                    _confirmarRemocao(context, lugar, lugarProvider);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Modal para editar o lugar
  void _abrirModalEdicao(BuildContext context, Lugar lugar) {
    final nomeController = TextEditingController(text: lugar.titulo);
    final imagemController = TextEditingController(text: lugar.imagemUrl);
    final recomendacoesController =
        TextEditingController(text: lugar.recomendacoes.join(','));
    final avaliacaoController =
        TextEditingController(text: lugar.avaliacao.toString());
    final custoMedioController =
        TextEditingController(text: lugar.custoMedio.toString());

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Editar Lugar'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome do Lugar'),
                ),
                TextField(
                  controller: imagemController,
                  decoration: InputDecoration(labelText: 'URL da Imagem'),
                ),
                TextField(
                  controller: recomendacoesController,
                  decoration: InputDecoration(labelText: 'Recomendações'),
                ),
                TextField(
                  controller: avaliacaoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Avaliação'),
                ),
                TextField(
                  controller: custoMedioController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Custo Médio'),
                ),
              ],
            ),
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
                final lugarAtualizado = Lugar(
                  id: lugar.id, // Mantém o mesmo ID
                  titulo: nomeController.text, // Novo nome
                  paises: lugar
                      .paises, // Mantém os países (você pode querer permitir editar isso também)
                  imagemUrl: imagemController.text, // Novo valor para a imagem
                  recomendacoes: recomendacoesController.text
                      .split(','), // Separar as recomendações por vírgula
                  avaliacao: double.tryParse(avaliacaoController.text) ??
                      lugar
                          .avaliacao, // Valor atualizado da avaliação (ou mantém o antigo caso não seja válido)
                  custoMedio: double.tryParse(custoMedioController.text) ??
                      lugar
                          .custoMedio, // Valor atualizado do custo médio (ou mantém o antigo caso não seja válido)
                );

                // Acessa o LugarProvider corretamente
                Provider.of<LugarProvider>(context, listen: false)
                    .editarLugar(lugar.id, lugarAtualizado);

                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para confirmar a remoção do lugar
  void _confirmarRemocao(
      BuildContext context, Lugar lugar, LugarProvider lugarProvider) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Confirmar Remoção'),
          content: Text('Você realmente deseja remover este lugar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o modal
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                lugarProvider.removerLugar(lugar);
                Navigator.of(ctx).pop(); // Fecha o modal
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lugar removido com sucesso!')),
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
