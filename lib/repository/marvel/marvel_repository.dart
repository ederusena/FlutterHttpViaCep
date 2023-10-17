import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart' as crypto;
// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';
import 'package:trilhapp/model/characters_marvel_model.dart';
import 'package:trilhapp/repository/marvel/marvel_baseurl.dart';

class MarvelRepository {
  Future<CharacterMarvelModel> getCharacters(int offset) async {
    var marvelBaseUrl = MarvelBaseUrl();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var privateKey = dotenv.get("MARVEL_API_KEY");
    var publicKey = dotenv.get("MARVEL_API_PUBLIC_KEY");
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query =
        "offset=${offset.toString()}&ts=$ts&apikey=$publicKey&hash=$hash";

    var response = await marvelBaseUrl.dio.get("/characters?$query");
    var charactersModel = CharacterMarvelModel.fromJson(response.data);

    return charactersModel;
  }
}

_generateMd5(String data) {
  var content = const Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
