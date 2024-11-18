import 'package:flutter/material.dart';
import 'package:three_mini_projeto/model/lugar.dart';
import 'package:three_mini_projeto/model/pais.dart';
import 'package:three_mini_projeto/data/dados.dart';

class LugarProvider with ChangeNotifier {
  final List<Lugar> _lugares;

  // Construtor para inicializar _lugares com a lista 'lugares' do arquivo dados.dart
  LugarProvider()
      : _lugares = List.from(
            lugares); // Aqui estamos acessando 'lugares' fora da classe

  // Getter para acessar a lista de lugares
  List<Lugar> get lugaresProvider => List.unmodifiable(_lugares);

  // Método para adicionar um lugar
  void adicionarLugar(Lugar lugar) {
    _lugares.add(lugar);
    notifyListeners(); // Notifica os ouvintes para atualizar a UI
  }

  // Método para pegar lugares por país
  List<Lugar> getLugaresPorPais(Pais pais) {
    var lugaresFiltrados = _lugares.where((lugar) {
      bool contains = lugar.paises.contains(pais.id);

      return contains; // Retorna o filtro
    }).toList();

    return lugaresFiltrados;
  } // Método para remover um lugar

  void removerLugar(Lugar lugar) {
    print("Removendo lugar: ${lugar.titulo}, id: ${lugar.id}");
    final lugarIndex = _lugares.indexWhere((item) => item.id == lugar.id);
    print("Índice encontrado: $lugarIndex");
    if (lugarIndex >= 0) {
      _lugares.removeAt(lugarIndex);
      print("Lugar removido com sucesso.");
      notifyListeners();
    } else {
      print("Lugar não encontrado.");
    }
  }

// Método para editar um lugar
  void editarLugar(String id, Lugar lugarAtualizado) {
    final lugarIndex = _lugares.indexWhere((lugar) => lugar.id == id);
    if (lugarIndex >= 0) {
      _lugares[lugarIndex] = lugarAtualizado;
      notifyListeners(); // Atualiza a UI
    }
  }
}
