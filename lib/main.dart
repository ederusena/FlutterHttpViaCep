import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trilhapp/model/dados_cadastrais_model.dart';
import 'package:trilhapp/model/tarefa_hive_model.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);

  // Registrar adaptador HIVE, criado atravez da model dados_cadastrais_model.dart
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  runApp(const MyApp());
}
