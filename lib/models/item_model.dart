/// Modelo de item
/// Este modelo é responsável por representar um item da lista de compras.
/// Ele possui um [id] único, um [nome] e um [comprado].
class ItemModel {
  final String id;
  final String nome;
  final bool comprado;

  ItemModel({
    required this.id,
    required this.nome,
    required this.comprado,
  });

  /// Cria uma cópia do modelo com os novos valores passados.
  ItemModel copyWith({
    String? id,
    String? nome,
    bool? comprado,
  }) {
    return ItemModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      comprado: comprado ?? this.comprado,
    );
  }
}
