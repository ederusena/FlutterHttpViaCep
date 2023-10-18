import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrasilFieldPage extends StatefulWidget {
  const BrasilFieldPage({super.key});

  @override
  State<BrasilFieldPage> createState() => _BrasilFieldPageState();
}

class _BrasilFieldPageState extends State<BrasilFieldPage> {
  var cepController = TextEditingController();
  var cpfController = TextEditingController();
  var centavosController = TextEditingController();
  var isCpfValid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.all(20),
      child: Scaffold(
        body: ListView(
          children: [
            TextFormField(
              controller: centavosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Moeda",
                hintText: "Digite o valor",
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: true)
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CEP",
                hintText: "Digite o CEP",
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cpfController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CPF",
                hintText: "Digite o CPF",
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [Text("CPF is Valid: $isCpfValid")],
            ),
            Center(
                child: TextButton(
              onPressed: () {
                setState(() {
                  isCpfValid = CPFValidator.isValid(cpfController.text);
                });
              },
              child: const Text("Validar"),
            ))
          ],
        ),
      ),
    ));
  }
}
