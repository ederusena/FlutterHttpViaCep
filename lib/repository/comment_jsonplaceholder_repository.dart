import 'package:http/http.dart' as http;
import 'package:trilhapp/model/comment_model.dart';
import 'dart:convert';

class CommentRepository {
  Future<List<CommentModel>> consultarComentario(int post) async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$post/comments"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return (json as List).map((e) => CommentModel.fromJson(e)).toList();
    }
    return [];
  }
}
