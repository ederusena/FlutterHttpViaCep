import 'package:flutter/material.dart';
import 'package:trilhapp/model/comment_model.dart';
import 'package:trilhapp/repository/comment_jsonplaceholder_repository.dart';

class CommentPage extends StatefulWidget {
  final int postId;
  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var commentRepository = CommentRepository();
  var commentList = <CommentModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    var lista = await commentRepository.consultarComentario(widget.postId);
    setState(() {
      commentList = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar:
                AppBar(title: Text("Comentários do Post: ${widget.postId}")),
            body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: commentList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: Colors.redAccent,
                            backgroundColor: Colors.white,
                            strokeWidth: 150),
                      )
                    : ListView.builder(
                        itemCount: commentList.length,
                        itemBuilder: (_, index) {
                          var comment = commentList[index];
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Card(
                                  child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(comment.name,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            const SizedBox(height: 8),
                                            Text(comment.body,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            const SizedBox(height: 8),
                                            Text(comment.email,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ]))));
                        }))));
    // ListTile(
    //       title: Text(posts[index].title),
    //       subtitle: Text(posts[index].body))
  }
}
