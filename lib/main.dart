import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trilhapp/model/dados_cadastrais_model.dart';
import 'package:trilhapp/model/tarefa_hive_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // Obter o diretorio de documentos do dispositivo
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  // Inicializar o Hive
  Hive.init(documentsDirectory.path);
  // Registrar adaptador HIVE, criado atravez da model dados_cadastrais_model.dart
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('pt', 'BR'),
        child: const MyApp()),
  );
}
