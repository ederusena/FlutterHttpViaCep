import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextPage extends StatefulWidget {
  const AutoSizeTextPage({super.key});

  @override
  State<AutoSizeTextPage> createState() => _AutoSizeTextPageState();
}

class _AutoSizeTextPageState extends State<AutoSizeTextPage> {
  var controllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        TextField(
          controller: controllerText,
          maxLines: 5,
          onChanged: (value) => setState(() {}),
          decoration: const InputDecoration(
              labelText: "Digite o texto que deseja exibir"),
        ),
        Container(
            margin: const EdgeInsets.all(10),
            child: Card(
                child: Container(
              padding: const EdgeInsets.all(14),
              child: AutoSizeText(maxLines: 10, controllerText.text),
            ))),
      ],
    )));
  }
}
