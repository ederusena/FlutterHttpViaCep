// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trilhapp/model/configuracao_hive_model.dart';
import 'package:trilhapp/repository/configuracao_hive_repository.dart';

class ConfiguracaoHivePage extends StatefulWidget {
  const ConfiguracaoHivePage({super.key});

  @override
  State<ConfiguracaoHivePage> createState() => _ConfiguracaoHivePageState();
}

class _ConfiguracaoHivePageState extends State<ConfiguracaoHivePage> {
  late ConfiguracaoHiveRepository configuracaoRepository;
  var configuracaoesModel = ConfiguracaoHiveModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracaoRepository = await ConfiguracaoHiveRepository.carregar();
    configuracaoesModel = configuracaoRepository.obterDados();

    nomeUsuarioController.text = configuracaoesModel.nomeUsuario;
    alturaController.text = configuracaoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Configurações")),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Nome do Usuário",
                  hintText: "Digite seu nome",
                  border: OutlineInputBorder(),
                ),
                controller: nomeUsuarioController,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura",
                  hintText: "Digite sua altura",
                  border: OutlineInputBorder(),
                ),
                controller: alturaController,
              ),
              SwitchListTile(
                  title: configuracaoesModel.receberNotificacoes
                      ? const Text("Desativar Notificações")
                      : const Text("Ativar Notificações"),
                  value: configuracaoesModel.receberNotificacoes,
                  secondary: configuracaoesModel.receberNotificacoes
                      ? const Icon(Icons.notifications_active)
                      : const Icon(Icons.notifications_off),
                  onChanged: (bool value) {
                    setState(() {
                      configuracaoesModel.receberNotificacoes =
                          !configuracaoesModel.receberNotificacoes;
                    });
                  }),
              SwitchListTile(
                  title: configuracaoesModel.temaEscuro
                      ? const Text("Dark Mode")
                      : const Text("Light Mode"),
                  value: configuracaoesModel.temaEscuro,
                  secondary: configuracaoesModel.temaEscuro
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  onChanged: (bool value) {
                    setState(() {
                      configuracaoesModel.temaEscuro = value;
                    });
                  }),
              TextButton(
                onPressed: () async {
                  // Bug com o teclado aberto
                  FocusManager.instance.primaryFocus?.unfocus();

                  try {
                    configuracaoesModel.altura =
                        double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Erro"),
                            content: const Text(
                                "Altura inválida, digitar altura em metros usando ponto: Ex: 1.75"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              )
                            ],
                          );
                        });
                    return;
                  }
                  configuracaoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracaoRepository.salvar(configuracaoesModel);
                  Navigator.pop(context, "OK!");
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 60)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 58, 150, 255)),
                ),
                child: const Text("Salvar",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
