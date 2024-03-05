import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

/// Classe principal do aplicativo.
/// Ela é um [StatelessWidget] que é responsável por criar o [MaterialApp] e definir a tela inicial do aplicativo.
/// A tela inicial é a [HomeScreen].
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de compras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
