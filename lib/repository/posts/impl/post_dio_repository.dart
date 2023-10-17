import 'package:trilhapp/repository/jsonplaceholder_custom_dio.dart';
import 'package:trilhapp/repository/posts/interfaces/post_interface.dart';
import 'package:trilhapp/model/post_model.dart';

class PostDioRepository implements PostsInterface {
  @override
  Future<List<PostModel>> getPosts() async {
    var jsonPlacehoderCustomDio = JsonPlacehoderCustomDio();
    var response = await jsonPlacehoderCustomDio.dio.get("/posts");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
