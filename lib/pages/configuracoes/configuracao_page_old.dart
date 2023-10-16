// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracaoPageOld extends StatefulWidget {
  const ConfiguracaoPageOld({super.key});

  @override
  State<ConfiguracaoPageOld> createState() => _ConfiguracaoPageOldState();
}

class _ConfiguracaoPageOldState extends State<ConfiguracaoPageOld> {
  late SharedPreferences storage;

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;

  final chaveNomeUsuario = "chave_nome_usuario";
  final chaveAltura = "chave_altura";
  final chaveReceberPushNotification = "chave_receber_push_notification";
  final chaveTemaEscuro = "chave_tema_escuro";

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();

    setState(() {
      nomeUsuarioController.text = storage.getString(chaveNomeUsuario) ?? "";
      alturaController.text = (storage.getDouble(chaveAltura) ?? 0).toString();
      receberPushNotification =
          storage.getBool(chaveReceberPushNotification) ?? false;
      temaEscuro = storage.getBool(chaveTemaEscuro) ?? false;
    });
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
                  title: receberPushNotification
                      ? const Text("Desativar Notificações")
                      : const Text("Ativar Notificações"),
                  value: receberPushNotification,
                  secondary: receberPushNotification
                      ? const Icon(Icons.notifications_active)
                      : const Icon(Icons.notifications_off),
                  onChanged: (bool value) {
                    setState(() {
                      receberPushNotification = !receberPushNotification;
                    });
                  }),
              SwitchListTile(
                  title: temaEscuro
                      ? const Text("Dark Mode")
                      : const Text("Light Mode"),
                  value: temaEscuro,
                  secondary: temaEscuro
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  onChanged: (bool value) {
                    setState(() {
                      temaEscuro = value;
                    });
                  }),
              TextButton(
                onPressed: () async {
                  // Bug com o teclado aberto
                  FocusManager.instance.primaryFocus?.unfocus();

                  try {
                    await storage.setDouble(
                        chaveAltura, double.parse(alturaController.text));
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
                  await storage.setString(
                      chaveNomeUsuario, nomeUsuarioController.text);
                  await storage.setBool(
                      chaveReceberPushNotification, receberPushNotification);
                  await storage.setBool(chaveTemaEscuro, temaEscuro);
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
