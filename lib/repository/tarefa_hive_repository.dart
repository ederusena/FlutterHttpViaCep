import 'package:hive/hive.dart';
import 'package:trilhapp/model/tarefa_hive_model.dart';

class TarefasHiveRepository {
  static late Box _box;
  TarefasHiveRepository._criar();

  static Future<TarefasHiveRepository> carregar() async {
    if (Hive.isBoxOpen('TarefaHiveModel')) {
      _box = Hive.box('TarefaHiveModel');
    } else {
      _box = await Hive.openBox('TarefaHiveModel');
    }
    return TarefasHiveRepository._criar();
  }

  salvar(TarefaHiveModel tarefasHiveModel) {
    _box.add(tarefasHiveModel);
  }

  alterar(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values
          .cast<TarefaHiveModel>()
          .where((element) => !element.concluido)
          .toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }
}
