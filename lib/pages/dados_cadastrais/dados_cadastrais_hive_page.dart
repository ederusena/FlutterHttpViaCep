import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trilhapp/model/dados_cadastrais_model.dart';
import 'package:trilhapp/repository/dados_cadastrais_repository.dart';
import 'package:trilhapp/repository/linguagens_repository.dart';
import 'package:trilhapp/repository/nivel_repository.dart';
import 'package:trilhapp/shared/widget/separator.dart';
import 'package:trilhapp/shared/widget/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagemRepository = LinguagensRepository();

  var linguagens = [];
  var niveis = [];
  bool salvando = false;

  @override
  void initState() {
    linguagens = linguagemRepository.getLinguagens();
    niveis = nivelRepository.getNiveis();
    super.initState();
    carregaDados();
  }

  carregaDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();

    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ""
        : dadosCadastraisModel.dataNascimento.toString();

    setState(() {});
  }

  List<DropdownMenuItem<int>> getAnosExperiencia(int anos) {
    var lista = <DropdownMenuItem<int>>[];
    for (var i = 1; i < anos; i++) {
      lista.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return lista;
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            value: dadosCadastraisModel.tempoExperiencia,
                            items: returnItens(20),
                            onChanged: (value) => {
                                  setState(() {
                                    dadosCadastraisModel.tempoExperiencia =
                                        int.parse(value.toString());
                                  })
                                }),
                        Column(
                          children: niveis
                              .map((e) => RadioListTile(
                                    dense: true,
                                    title: Text(e.toString()),
                                    selected:
                                        dadosCadastraisModel.nivelExperiencia ==
                                            e.toString(),
                                    value: e.toString(),
                                    groupValue:
                                        dadosCadastraisModel.nivelExperiencia,
                                    onChanged: (value) {
                                      setState(() {
                                        dadosCadastraisModel.nivelExperiencia =
                                            value.toString();
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
                                    value: dadosCadastraisModel.linguagens!
                                        .contains(e),
                                    onChanged: (bool? value) {
                                      if (value!) {
                                        setState(() {
                                          dadosCadastraisModel.linguagens!
                                              .add(e);
                                        });
                                      } else {
                                        setState(() {
                                          dadosCadastraisModel.linguagens!
                                              .remove(e);
                                        });
                                      }
                                    },
                                  ))
                              .toList(),
                        ),
                        const TextLabel(texto: "Tempo de experiência"),
                        TextLabel(
                            texto:
                                "Pretenção salarial R\$ ${dadosCadastraisModel.salario?.round()}"),
                        Slider(
                            min: 0,
                            max: 15000,
                            value: dadosCadastraisModel.salario ?? 0,
                            onChanged: (double value) {
                              setState(() {
                                dadosCadastraisModel.salario = value;
                              });
                            }),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              salvando = false;
                            });
                            if (nomeController.text.trim().length < 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("O nome deve ser preenchido")));
                              return;
                            }
                            // if (dadosCadastraisModel.dataNascimento == null) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content:
                            //               Text("Data de nascimento inválida")));
                            //   return;
                            // }
                            if (dadosCadastraisModel.nivelExperiencia == null ||
                                dadosCadastraisModel.nivelExperiencia!.trim() ==
                                    '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "O nível deve ser selecionado")));
                              return;
                            }
                            if (dadosCadastraisModel.linguagens!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Deve ser selecionado ao menos uma linguagem")));
                              return;
                            }
                            if (dadosCadastraisModel.tempoExperiencia == null ||
                                dadosCadastraisModel.tempoExperiencia == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Deve ter ao menos um ano de experiência em uma das linguagens")));
                              return;
                            }
                            if (dadosCadastraisModel.salario == null ||
                                dadosCadastraisModel.salario == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "A pretenção salarial deve ser maior que 0")));
                              return;
                            }
                            dadosCadastraisModel.nome = nomeController.text;
                            dadosCadastraisRepository
                                .salvar(dadosCadastraisModel);
                            setState(() {
                              salvando = true;
                            });
                            Future.delayed(const Duration(seconds: 3), () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Dados salvo com sucesso")));
                              setState(() {
                                salvando = false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }
}
