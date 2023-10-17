import 'package:flutter/material.dart';
import 'package:trilhapp/model/cep.dart';
import 'package:trilhapp/repository/via_cep_repository.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  var viaCepModel = ViaCepModel();
  var viaCepRepository = ViaCepHttpRepository();

  var cepController = TextEditingController(text: "");
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            const Text("Consulta de CEP",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            TextField(
              controller: cepController,
              maxLength: 8,
              keyboardType: TextInputType.number,
              onChanged: (String value) async {
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');

                if (cep.length == 8) {
                  setState(() {
                    isLoading = true;
                  });
                  viaCepModel = await viaCepRepository.consultarCEP(cep);
                  // Bug com o teclado aberto
                  FocusManager.instance.primaryFocus?.unfocus();
                }

                setState(() {
                  isLoading = false;
                });
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "CEP"),
            ),
            const SizedBox(height: 50),
            Visibility(
                visible: isLoading, child: const CircularProgressIndicator()),
            Visibility(
              visible: !isLoading,
              child: Column(
                children: [
                  Text(viaCepModel.logradouro ?? "",
                      style: const TextStyle(fontSize: 22)),
                  Text(
                      "${viaCepModel.localidade ?? ''} - ${viaCepModel.uf ?? ''}",
                      style: const TextStyle(fontSize: 22)),
                ],
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    ));
  }
}
