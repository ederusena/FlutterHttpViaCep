// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _descricao = "";
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  String get id => _id;

  bool get concluido => _concluido;
  set concluido(bool concluido) {
    _concluido = concluido;
  }

  String get descricao => _descricao;
  set description(String descricao) {
    _descricao = descricao;
  }
}
