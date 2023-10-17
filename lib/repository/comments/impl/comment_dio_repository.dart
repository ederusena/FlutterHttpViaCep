import 'package:dio/dio.dart';
import 'package:trilhapp/model/comment_model.dart';

import 'package:trilhapp/repository/comments/interfaces/comment_interface.dart';

class CommentDioRepository implements ICommentRepository {
  @override
  Future<List<CommentModel>> getComments(int post) async {
    var dio = Dio();
    var response = await dio
        .get("https://jsonplaceholder.typicode.com/posts/$post/comments");

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
