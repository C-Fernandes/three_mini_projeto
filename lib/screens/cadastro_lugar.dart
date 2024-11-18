import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:three_mini_projeto/data/dados.dart';
import 'package:three_mini_projeto/components/item_pais.dart';
import 'package:uuid/uuid.dart';
import 'package:three_mini_projeto/model/lugar.dart';
import 'package:three_mini_projeto/model/pais.dart';
import 'package:three_mini_projeto/providers/lugar_provider.dart';

class CadastroLugarScreen extends StatefulWidget {
  const CadastroLugarScreen({super.key});

  @override
  _CadastroLugarScreenState createState() => _CadastroLugarScreenState();
}

class _CadastroLugarScreenState extends State<CadastroLugarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recomendacoesController = TextEditingController();

  String _titulo = '';
  String _imagemUrl = '';
  final List<String> _recomendacoes = [];
  double _avaliacao = 0.0;
  double _custoMedio = 0.0;
  List<Pais> _paisesSelecionados = [];

  @override
  void dispose() {
    _recomendacoesController.dispose();
    super.dispose();
  }

  void _salvarLugar() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Gerar ID único
      var uuid = const Uuid();
      String id = uuid.v4();

      // Gerar recomendações com numeração apenas para salvar
      List<String> recomendacoesFormatadas = _recomendacoes
          .asMap()
          .entries
          .map((entry) => '${entry.key + 1}. ${entry.value}')
          .toList();

      // Criação do Lugar com os dados
      Lugar novoLugar = Lugar(
        id: id,
        paises: _paisesSelecionados.map((pais) => pais.id).toList(),
        titulo: _titulo,
        imagemUrl: _imagemUrl,
        recomendacoes: recomendacoesFormatadas,
        avaliacao: _avaliacao,
        custoMedio: _custoMedio,
      );

      // Adiciona o novo lugar ao provider
      Provider.of<LugarProvider>(context, listen: false).adicionarLugar(novoLugar);

      // Exibir Snackbar confirmando a criação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lugar "${novoLugar.titulo}" adicionado!')),
      );

      // Navegar para a tela de países
      Navigator.of(context).pop();
    }
  }
  void _selecionarPaises() async {
  // Cria uma nova lista para controlar os países selecionados dentro do Dialog
  List<Pais> paisesSelecionadosTemp = List.from(_paisesSelecionados);

  final paisesEscolhidos = await showDialog<List<Pais>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Selecione um ou mais países'),
        content: SingleChildScrollView(
          child: Column(
            children: paises.map((pais) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return CheckboxListTile(
                    title: Text(pais.titulo),
                    value: paisesSelecionadosTemp.contains(pais), // Verifica se o país está selecionado
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          paisesSelecionadosTemp.add(pais); // Adiciona o país à lista
                        } else {
                          paisesSelecionadosTemp.remove(pais); // Remove o país da lista
                        }
                      });
                    },
                  );
                },
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(paisesSelecionadosTemp); // Passa a lista de países selecionados
            },
          ),
        ],
      );
    },
  );

  if (paisesEscolhidos != null) {
    setState(() {
      _paisesSelecionados = paisesEscolhidos; // Atualiza a lista de países selecionados na tela principal
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Campo Título
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  onSaved: (value) => _titulo = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                // Campo Imagem URL
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Imagem URL'),
                  onSaved: (value) => _imagemUrl = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma URL de imagem';
                    }
                    if (!Uri.parse(value).isAbsolute) {
                      return 'Por favor, insira uma URL válida';
                    }
                    return null;
                  },
                ),
                // Selecionar Países
                GestureDetector(
                  onTap: _selecionarPaises,
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: _paisesSelecionados.isNotEmpty
                            ? _paisesSelecionados.map((pais) => pais.titulo).join(', ')
                            : 'Selecione um ou mais países',
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Recomendações
                const Text('Recomendações', style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Adicionar recomendação',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_recomendacoesController.text.isNotEmpty) {
                            _recomendacoes.add(_recomendacoesController.text);
                            _recomendacoesController.clear();
                          }
                        });
                      },
                    ),
                  ),
                  controller: _recomendacoesController,
                ),
                Wrap(
                  children: _recomendacoes.map((recomendacao) {
                    return Chip(
                      label: Text(recomendacao), // Mostra apenas o texto sem numeração
                      onDeleted: () {
                        setState(() {
                          _recomendacoes.remove(recomendacao);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Campo Avaliação
                const Text('Avaliação', style: TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: _avaliacao,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _avaliacao.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _avaliacao = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Campo Custo Médio
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Custo Médio (R\$)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      _custoMedio = double.tryParse(value) ?? 0.0;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um custo médio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um valor válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Botão Salvar
                ElevatedButton(
                  onPressed: _salvarLugar,
                  child: const Text('Salvar Lugar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
