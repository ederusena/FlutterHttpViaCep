import 'package:hive/hive.dart';
import 'package:trilhapp/model/configuracao_hive_model.dart';

class ConfiguracaoHiveRepository {
  static late Box _box;
  ConfiguracaoHiveRepository._criar();

  static Future<ConfiguracaoHiveRepository> carregar() async {
    if (Hive.isBoxOpen('configuracao')) {
      _box = Hive.box('configuracao');
    } else {
      _box = await Hive.openBox('configuracao');
    }
    return ConfiguracaoHiveRepository._criar();
  }

  void salvar(ConfiguracaoHiveModel configuracaoModel) {
    _box.put('configuracaoModel', {
      'nomeUsuario': configuracaoModel.nomeUsuario,
      'altura': configuracaoModel.altura,
      'receberNotificacoes': configuracaoModel.receberNotificacoes,
      'temaEscuro': configuracaoModel.temaEscuro,
    });
  }

  ConfiguracaoHiveModel obterDados() {
    var configuracao = _box.get('configuracaoModel');
    if (configuracao == null) {
      return ConfiguracaoHiveModel.vazio();
    }

    return ConfiguracaoHiveModel(
      configuracao['nomeUsuario'],
      configuracao['altura'],
      configuracao['receberNotificacoes'],
      configuracao['temaEscuro'],
    );
  }
}
