import 'package:flutter/material.dart';
import 'package:three_mini_projeto/model/lugar.dart';

class ItemLugar extends StatelessWidget {
  final Lugar lugar;
  final bool isGerenciamento;

  const ItemLugar({
    super.key,
    required this.lugar,
    this.isGerenciamento = false, // Por padrão, não está no modo de gerenciamento
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detalheLugar',
          arguments: lugar,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    lugar.imagemUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      lugar.titulo,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.star),
                          const SizedBox(width: 6),
                          Text('${lugar.avaliacao}/5'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.attach_money),
                          const SizedBox(width: 6),
                          Text('custo: R\$${lugar.custoMedio}'),
                        ],
                      ),
                    ],
                  ),
                  if (isGerenciamento)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Implementar lógica para alterar
                            Navigator.of(context).pushNamed(
                              '/alterarLugar',
                              arguments: lugar,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Mostrar diálogo de confirmação
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirmação'),
                                content: const Text(
                                    'Deseja realmente remover este lugar?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Implementar lógica para remover
                                      Navigator.of(ctx).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Lugar removido!'),
                                        ),
                                      );
                                    },
                                    child: const Text('Confirmar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
