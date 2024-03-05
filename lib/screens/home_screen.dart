import 'package:crud_simples/controllers/home_controller.dart';
import 'package:crud_simples/models/item_model.dart';
import 'package:crud_simples/widgets/item_list_view.dart';
import 'package:crud_simples/widgets/novo_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Tela inicial do aplicativo.
/// Ela é responsável por adicionar, remover e marcar como comprado os itens.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Instância do [HomeController].
  final _homeController = HomeController();

  /// Adiciona um novo item à lista.
  void _addItem() async {
    /// Mostra o diálogo para adicionar um novo item.
    final String? nome = await NovoItemDialog.show(context);

    /// Se o nome for nulo, não faz nada.
    if (nome == null) {
      return;
    }

    /// Adiciona o item à lista.
    final item = _homeController.addItem(nome);

    /// Verifica se o widget ainda está montado devido a um possível atraso na execução do código.
    if (context.mounted) {
      /// Mostra um [SnackBar] informando que o item foi adicionado.
      /// E permite desfazer a ação.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Item adicionado'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              _homeController.removeItem(item.id);
            },
          ),
        ),
      );
    }
  }

  /// Remove um item da lista.
  void _removeItem(String id) {
    /// Obtém o item pelo seu [id].
    final item = _homeController.getItem(id);

    /// Remove o item da lista.
    _homeController.removeItem(id);

    /// Mostra um [SnackBar] informando que o item foi removido.
    /// E permite desfazer a ação.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removido'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            _homeController.addItem(item.nome);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de compras"),
      ),

      /// Utiliza o [ValueListenableBuilder] para reconstruir o widget quando a lista de itens é alterada.
      /// Ele é um ouvinte da lista de itens e reconstrói o widget quando a lista é alterada.
      body: ValueListenableBuilder<List<ItemModel>>(
        valueListenable: _homeController.items,
        builder: (context, items, child) {
          /// Se a lista de itens estiver vazia, mostra uma animação e uma mensagem.
          if (items.isEmpty) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Animação de nenhum item na lista.
                    Lottie.asset("assets/lottie/nenhum-item.json"),
                    Text(
                      'Nenhum item na lista',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Adicione um item para começar',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ),
            );
          }

          /// Se a lista de itens não estiver vazia, mostra a lista de itens.
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              /// Retorna o widget que representa o item.
              return ItemListVew(
                item: item,
                onToggle: (id) {
                  _homeController.toggleItem(id);
                },
                onRemove: (id) {
                  _removeItem(id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Adicionar item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
