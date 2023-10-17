import 'package:trilhapp/model/comment_model.dart';

abstract class ICommentRepository {
  Future<List<CommentModel>> getComments(int post);
}
