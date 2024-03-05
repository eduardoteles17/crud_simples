import 'package:crud_simples/models/item_model.dart';
import 'package:flutter/material.dart';

/// Widget responsável por exibir um item da lista.
/// Recebe um [ItemModel] e as funções [onRemove] e [onToggle].
/// Ele é um [Dismissible] que permite que o item seja removido da lista ao arrastá-lo para o lado.
/// Ele é um [CheckboxListTile] que permite que o item seja marcado como comprado ou não.
class ItemListVew extends StatelessWidget {
  final ItemModel item;

  final Function(String) onRemove;
  final Function(String) onToggle;

  const ItemListVew({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        onRemove(item.id);
      },
      child: CheckboxListTile(
        title: Text(
          item.nome,
          style: TextStyle(
            decoration: item.comprado ? TextDecoration.lineThrough : null,
          ),
        ),
        value: item.comprado,
        onChanged: (value) {
          onToggle(item.id);
        },
      ),
    );
  }
}
