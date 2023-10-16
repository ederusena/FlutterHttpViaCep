import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  // Configurar Hive para uso
  late Box boxNumeroAleatorios;

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
    if (Hive.isBoxOpen("numeros_aleatorios")) {
      boxNumeroAleatorios = Hive.box("numeros_aleatorios");
    } else {
      boxNumeroAleatorios = await Hive.openBox("numeros_aleatorios");
    }

    setState(() {
      numeroGerado = boxNumeroAleatorios.get(chaveNumeroAleatorio) ?? 0;
      quantidadeClicks = boxNumeroAleatorios.get(chaveQuantidadeClicks) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Números Aleatórios Hive")),
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
                  boxNumeroAleatorios.put(
                      chaveNumeroAleatorio, random.nextInt(10000));
                  boxNumeroAleatorios.put(
                      chaveQuantidadeClicks, ++quantidadeClicks);
                  carregarDados();
                });
              },
              child: const Icon(Icons.add),
            )));
  }
}
