import 'package:trilhapp/model/tarefas_back4app_model.dart';
import 'package:trilhapp/repository/back4app/tarefas_backapp_baseurl.dart';

class TarefasBack4AppRepository {
  var _tarefas = TarefasBack4ppBaseUrl();

  TarefasBack4AppRepository() {
    _tarefas = TarefasBack4ppBaseUrl();
  }

  Future<TarefasBack4AppModel> obterTarefas(bool apenasNaoConcluidos) async {
    var url = "/Tarefas";

    if (apenasNaoConcluidos) {
      url = "/Tarefas?where={\"concluido\":false}";
    }

    var response = await _tarefas.dio.get(url);
    var tarefasModel = TarefasBack4AppModel.fromJson(response.data);

    return tarefasModel;
  }

  Future<void> salvar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _tarefas.dio
          .post("/Tarefas", data: tarefaBack4AppModel.toJsonCreateTask());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> atualizar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _tarefas.dio.put("/Tarefas/${tarefaBack4AppModel.objectId}",
          data: tarefaBack4AppModel.toJsonCreateTask());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> excluir(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _tarefas.dio.delete("/Tarefas/${tarefaBack4AppModel.objectId}");
    } catch (e) {
      throw Exception(e);
    }
  }
}
