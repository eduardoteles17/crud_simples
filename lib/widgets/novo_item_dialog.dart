import 'package:flutter/material.dart';

/// Widget responsável por mostrar um diálogo para adicionar um novo item à lista.
/// Ele é um [AlertDialog] que possui um [TextFormField] para preencher o nome do item.
/// Ele retorna o nome do item adicionado. Através do [Navigator.pop].
class NovoItemDialog extends StatefulWidget {
  const NovoItemDialog({super.key});

  /// Método estático que mostra o diálogo para adicionar um novo item.
  /// Retorna o nome do item adicionado.
  static Future<String?> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const NovoItemDialog(),
    );
  }

  @override
  State<NovoItemDialog> createState() => _NovoItemDialogState();
}

class _NovoItemDialogState extends State<NovoItemDialog> {
  /// Chave para o formulário. Utilizada para validar e salvar o formulário.
  final _formKey = GlobalKey<FormState>();

  /// Nome do item.
  var _nome = '';

  /// Salva o nome do item.
  _onSaveNome(String? value) {
    setState(() {
      _nome = value!;
    });
  }

  /// Valida e salva o formulário. Retorna o nome do item.
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    Navigator.of(context).pop(_nome);
  }

  /// Cancela o diálogo.
  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo item'),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Adicionar'),
        ),
      ],
      content: SizedBox(
        child: Form(
          key: _formKey,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'Ex: Arroz',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              /// Valida se o campo está vazio. Se estiver, retorna uma mensagem de erro.
              if (value == null || value.isEmpty) {
                return 'Por favor, preencha o nome do item';
              }
              return null;
            },
            onSaved: _onSaveNome,
          ),
        ),
      ),
    );
  }
}
