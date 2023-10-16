// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS {
  NOME_USUARIO,
  ALTURA,
  RECEBER_PUSH_NOTIFICATION,
  TEMA_ESCURO
}

class AppStorageService {
  void setConfigNomeUsuario(String nome) async {
    _setString(STORAGE_KEYS.NOME_USUARIO, nome);
  }

  Future<String> getConfigNomeUsuario() async {
    return _getString(STORAGE_KEYS.NOME_USUARIO.toString());
  }

  void setConfigAltura(double altura) async {
    _setDouble(STORAGE_KEYS.ALTURA, altura);
  }

  Future<double> getConfigAltura() async {
    return _getDouble(STORAGE_KEYS.ALTURA);
  }

  void setConfigReceberPushNotification(bool receber) async {
    _setBool(STORAGE_KEYS.RECEBER_PUSH_NOTIFICATION, receber);
  }

  Future<bool> getConfigReceberPushNotification() async {
    return _getBool(STORAGE_KEYS.RECEBER_PUSH_NOTIFICATION.toString());
  }

  void setConfigTemaEscuro(bool receber) async {
    _setBool(STORAGE_KEYS.TEMA_ESCURO, receber);
  }

  Future<bool> getConfigTemaEscuro() async {
    return _getBool(STORAGE_KEYS.TEMA_ESCURO.toString());
  }

  _setString(STORAGE_KEYS key, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(key.toString(), value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setDouble(STORAGE_KEYS key, double value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(key.toString(), value);
  }

  Future<double> _getDouble(STORAGE_KEYS chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave.toString()) ?? 0;
  }

  _setBool(STORAGE_KEYS key, bool value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(key.toString(), value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }
}
