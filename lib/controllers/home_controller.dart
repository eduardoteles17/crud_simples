import 'package:crud_simples/models/item_model.dart';
import 'package:flutter/material.dart';

/// Classe responsável por gerenciar a tela inicial do aplicativo.
/// Ela é responsável por adicionar, remover e marcar como comprado os itens.
class HomeController {
  /// Lista de itens.
  /// Ela é um [ValueNotifier] que notifica os seus ouvintes quando a lista é alterada.
  /// Permitindo que o widget que a utiliza seja reconstruído, mesmo o estado sendo alterado fora do contexto do widget.
  final items = ValueNotifier<List<ItemModel>>([]);

  /// Adiciona um novo item à lista.
  /// Recebe o [nome] do item e retorna o [ItemModel] criado.
  ItemModel addItem(String nome) {
    final item = ItemModel(
      id: DateTime.now().toString(), /// Utiliza a data e hora atual como id.
      nome: nome,
      comprado: false,
    );
    items.value = [...items.value, item];

    return item;
  }

  /// Retorna um item da lista pelo seu [id].
  ItemModel getItem(String id) {
    return items.value.where((item) => item.id == id).first;
  }

  /// Remove um item da lista pelo seu [id].
  void removeItem(String id) {
    items.value = items.value.where((item) => item.id != id).toList();
  }

  /// Marca um item como comprado ou não. Recebe o [id] do item.
  void toggleItem(String id) {
    items.value = items.value.map((item) {
      if (item.id == id) {
        return item.copyWith(comprado: !item.comprado);
      }
      return item;
    }).toList();
  }
}
