import 'package:flutter/material.dart';
import 'package:three_mini_projeto/model/pais.dart';
import 'package:three_mini_projeto/data/dados.dart'; // Supondo que 'paises' esteja lá

class PaisProvider with ChangeNotifier {
  final List<Pais> _paises;

  // Construtor para inicializar _paises com a lista 'paises' do arquivo dados.dart
  PaisProvider() : _paises = List.from(paises); // Acessando a lista de países

  // Getter para acessar a lista de países
  List<Pais> get paisesProvider => List.unmodifiable(_paises);

  // Método para adicionar um novo país
  void adicionarPais(Pais pais) {
    _paises.add(pais);
    notifyListeners(); // Notifica os ouvintes para atualizar a UI
  }

  // Método para remover um país
  void removerPais(Pais pais) {
    final paisIndex = _paises.indexWhere((item) => item.id == pais.id);
    if (paisIndex >= 0) {
      _paises.removeAt(paisIndex);
      notifyListeners(); // Atualiza a UI
    }
  }

  // Método para editar um país
  void editarPais(String id, Pais paisAtualizado) {
    final paisIndex = _paises.indexWhere((pais) => pais.id == id);
    if (paisIndex >= 0) {
      _paises[paisIndex] = paisAtualizado;
      notifyListeners(); // Atualiza a UI
    }
  }
}
