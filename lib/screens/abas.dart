import 'package:three_mini_projeto/components/drawer.dart';
import 'package:three_mini_projeto/model/lugar.dart';
import 'package:three_mini_projeto/screens/favoritos.dart';
import 'package:three_mini_projeto/screens/pais_screen.dart';
import 'package:flutter/material.dart';


class MinhasAbas extends StatefulWidget {
  const MinhasAbas({super.key});

  @override
  State<MinhasAbas> createState() => _MinhasAbasState();
}

class _MinhasAbasState extends State<MinhasAbas> {
  String _nomeTab = "Países";
  final List<String> _nomeTabs = ["Países", "Favoritos"];

  void _getNomeTab(int index) {
    setState(() {
      _nomeTab = _nomeTabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                _nomeTab,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: ThemeData().primaryColor,
            ),
            drawer: const MeuDrawer(),
            body: Column(
              children: <Widget>[
                const Expanded(
                  child: TabBarView(
                    children: [
                      PaisScreen(),
                      FavoritosScreen(), // Sem necessidade de passar a lista de favoritos
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  decoration: BoxDecoration(
                    color: ThemeData().primaryColor,
                  ),
                  child: TabBar(
                      onTap: (index) {
                        _getNomeTab(index);
                      },
                      indicatorColor: Colors.amber,
                      labelColor: Colors.amber,
                      unselectedLabelColor: Colors.white60,
                      tabs: const [
                        Tab(
                          icon: Icon(
                            Icons.category,
                          ),
                          text: "Países",
                        ),
                        Tab(
                          icon: Icon(
                            Icons.star,
                          ),
                          text: "Favoritos",
                        )
                      ]),
                )
              ],
            )));
  }
}