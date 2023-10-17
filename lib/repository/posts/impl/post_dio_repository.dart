import 'package:trilhapp/repository/posts/interfaces/post_interface.dart';
import 'package:dio/dio.dart';
import 'package:trilhapp/model/post_model.dart';

class PostDioRepository implements PostsInterface {
  @override
  Future<List<PostModel>> getPosts() async {
    var dio = Dio();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
