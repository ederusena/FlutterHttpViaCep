import 'package:trilhapp/model/cep.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViaCepDioRepository {
  Future<ViaCepModel> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCepModel.fromJson(json);
    }
    return ViaCepModel();
  }
}
