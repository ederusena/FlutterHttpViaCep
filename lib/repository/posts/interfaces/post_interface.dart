import 'package:trilhapp/model/post_model.dart';

abstract class PostsInterface {
  Future<List<PostModel>> getPosts();
}
