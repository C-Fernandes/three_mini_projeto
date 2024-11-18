import 'package:flutter/material.dart';
import 'package:three_mini_projeto/model/lugar.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<Lugar> _lugaresFavoritos = [];

  List<Lugar> get lugaresFavoritos => List.unmodifiable(_lugaresFavoritos);

  void toggleFavorito(Lugar lugar) {
    if (_lugaresFavoritos.contains(lugar)) {
      _lugaresFavoritos.remove(lugar);
    } else {
      _lugaresFavoritos.add(lugar);
    }
    notifyListeners();
  }

  bool isFavorito(Lugar lugar) {
    return _lugaresFavoritos.contains(lugar);
  }
}
