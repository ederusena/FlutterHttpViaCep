import 'package:flutter/material.dart';
import 'package:trilhapp/model/tarefas_back4app_model.dart';
import 'package:trilhapp/repository/back4app/tarefas_back4app_repository.dart';

class TarefasBack4appPage extends StatefulWidget {
  const TarefasBack4appPage({Key? key}) : super(key: key);

  @override
  State<TarefasBack4appPage> createState() => _TarefasBack4appPageState();
}

class _TarefasBack4appPageState extends State<TarefasBack4appPage> {
  TarefasBack4AppRepository tarefaRepository = TarefasBack4AppRepository();

  var _tarefasBack4App = TarefasBack4AppModel([]);

  var descricaoContoller = TextEditingController();
  var apenasNaoConcluidos = false;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      isLoading = true;
    });
    _tarefasBack4App = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tarefas Back4App"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            descricaoContoller.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar tarefa"),
                    content: TextField(
                      controller: descricaoContoller,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            await tarefaRepository.salvar(
                                TarefaBack4AppModel.criar(
                                    descricaoContoller.text, false));
                            Navigator.pop(context);
                            obterTarefas();
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(4),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Apenas não concluídos",
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                          value: apenasNaoConcluidos,
                          onChanged: (bool value) {
                            apenasNaoConcluidos = value;
                            obterTarefas();
                          })
                    ],
                  ),
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 250, horizontal: 2),
                        child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _tarefasBack4App.tarefas.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var tarefa = _tarefasBack4App.tarefas[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              tarefaRepository.excluir(tarefa);
                              obterTarefas();
                            },
                            key: Key(tarefa.descricao ?? ""),
                            child: ListTile(
                              title: Text(tarefa.descricao ?? ""),
                              trailing: Switch(
                                onChanged: (bool value) async {
                                  tarefa.concluido = value;
                                  await tarefaRepository.atualizar(tarefa);
                                  obterTarefas();
                                },
                                value: tarefa.concluido ?? false,
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ));
  }
}
