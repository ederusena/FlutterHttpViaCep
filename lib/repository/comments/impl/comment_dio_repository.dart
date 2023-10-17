import 'package:dio/dio.dart';
import 'package:trilhapp/model/comment_model.dart';

import 'package:trilhapp/repository/comments/interfaces/comment_interface.dart';
import 'package:trilhapp/repository/jsonplaceholder_custom_dio.dart';

class CommentDioRepository implements ICommentRepository {
  @override
  Future<List<CommentModel>> getComments(int post) async {
    var jsonPlacehoderCustomDio = JsonPlacehoderCustomDio();
    var response =
        await jsonPlacehoderCustomDio.dio.get("/posts/$post/comments");

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
