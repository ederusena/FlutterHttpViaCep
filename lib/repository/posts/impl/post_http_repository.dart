import 'package:http/http.dart' as http;
import 'package:trilhapp/repository/posts/interfaces/post_interface.dart';
import 'dart:convert';

import 'package:trilhapp/model/post_model.dart';

class PostHttpRepository implements PostsInterface {
  @override
  Future<List<PostModel>> getPosts() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return (json as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
