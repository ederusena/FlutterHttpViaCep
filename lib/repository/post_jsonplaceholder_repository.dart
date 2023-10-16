import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trilhapp/model/post_model.dart';

class PostRepository {
  Future<List<PostModel>> consultarPost() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return (json as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
