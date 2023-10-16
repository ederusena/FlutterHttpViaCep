import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() =>
      _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState
    extends State<NumerosAleatoriosSharedPreferencesPage> {
  late SharedPreferences storage;

  int numeroGerado = 0;
  int quantidadeClicks = 0;

  final chaveNumeroAleatorio = "numero_aleatorio";
  final chaveQuantidadeClicks = "quantidade_clicks";

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();

    setState(() {
      numeroGerado = storage.getInt(chaveNumeroAleatorio) ?? 0;
      quantidadeClicks = storage.getInt(chaveQuantidadeClicks) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Números Aleatórios")),
            body: Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(numeroGerado.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  Text("Quantidade de clicks: $quantidadeClicks",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var random = Random();

                setState(() {
                  storage.setInt(chaveNumeroAleatorio, random.nextInt(10000));
                  storage.setInt(chaveQuantidadeClicks, ++quantidadeClicks);
                  carregarDados();
                });
              },
              child: const Icon(Icons.add),
            )));
  }
}
