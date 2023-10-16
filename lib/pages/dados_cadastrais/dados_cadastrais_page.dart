import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trilhapp/pages/home_page.dart';
import 'package:trilhapp/repository/linguagens_repository.dart';
import 'package:trilhapp/repository/nivel_repository.dart';
import 'package:trilhapp/shared/widget/separator.dart';
import 'package:trilhapp/shared/widget/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagemRepository = LinguagensRepository();
  var linguagens = [];
  var linguagensSelecionadas = [];
  var niveis = [];
  bool salvando = false;
  int tempoExperiencia = 1;
  var nivelSelecionado = "";
  double salarioEscolhido = 0;

  @override
  void initState() {
    linguagens = linguagemRepository.getLinguagens();
    niveis = nivelRepository.getNiveis();
    super.initState();
  }

  List<DropdownMenuItem<int>> getAnosExperiencia(int anos) {
    var lista = <DropdownMenuItem<int>>[];
    for (var i = 1; i < anos; i++) {
      lista.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus Dados"),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Colors.redAccent),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: salvando
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                  ))
                : ListView(
                    children: [
                      const TextLabel(texto: "Nome"),
                      TextField(
                        controller: nomeController,
                        decoration: const InputDecoration(
                          hintText: "Digite seu nome",
                        ),
                      ),
                      const Separator(),
                      const TextLabel(texto: "Data de Nascimento"),
                      TextField(
                        controller: dataNascimentoController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000, 1, 1),
                              firstDate: DateTime(1940, 1, 1),
                              lastDate: DateTime(2050, 1, 1));

                          dataNascimentoController.text =
                              data.toString().substring(0, 10).trim();
                        },
                      ),
                      const Separator(),
                      const TextLabel(texto: "Nível de experiência"),
                      DropdownButton(
                          isExpanded: true,
                          value: tempoExperiencia,
                          items: getAnosExperiencia(20),
                          onChanged: (value) => {
                                setState(() {
                                  tempoExperiencia = value as int;
                                })
                              }),
                      Column(
                        children: niveis
                            .map((e) => RadioListTile(
                                  dense: true,
                                  title: Text(e.toString()),
                                  selected: nivelSelecionado == e.toString(),
                                  value: e.toString(),
                                  groupValue: nivelSelecionado,
                                  onChanged: (value) {
                                    setState(() {
                                      nivelSelecionado = value.toString();
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      const TextLabel(texto: "Linguagens preferidas"),
                      Column(
                        children: linguagens
                            .map((e) => CheckboxListTile(
                                  title: Text(e),
                                  value: linguagensSelecionadas.contains(e),
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      setState(() {
                                        linguagensSelecionadas.add(e);
                                      });
                                    } else {
                                      setState(() {
                                        linguagensSelecionadas.remove(e);
                                      });
                                    }
                                  },
                                ))
                            .toList(),
                      ),
                      const TextLabel(texto: "Tempo de experiência"),
                      TextLabel(
                          texto:
                              "Pretenção salarial R\$ ${salarioEscolhido.round()}"),
                      Slider(
                          min: 0,
                          max: 15000,
                          value: salarioEscolhido,
                          onChanged: (double value) {
                            setState(() {
                              salarioEscolhido = value;
                            });
                          }),
                      TextButton(
                        onPressed: () => {
                          if (nomeController.text == "" &&
                              nomeController.text.trim().length < 3)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Nome Inválido"),
                                  backgroundColor: Colors.red,
                                ),
                              )
                            }
                          else if (dataNascimentoController.text.isEmpty)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Data de Nascimento Inválido"),
                                ),
                              )
                            }
                          else if (nivelSelecionado.trim() == "")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text("Nível de experiência Inválido"),
                                ),
                              )
                            }
                          else if (linguagensSelecionadas.isEmpty)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text("Linguagens preferidas Inválido"),
                                ),
                              )
                            }
                          else if (salarioEscolhido == 0)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Pretenção salarial Inválido"),
                                ),
                              )
                            }
                          else
                            {
                              setState(() {
                                salvando = true;
                              }),
                              Future.delayed(const Duration(seconds: 4), () {
                                setState(() {
                                  salvando = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("Dados salvos com sucesso"),
                                    ),
                                  );
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainPage()));
                              }),
                            }
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
