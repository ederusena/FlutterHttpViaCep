import 'package:flutter/material.dart';
import 'package:trilhapp/model/post_model.dart';
import 'package:trilhapp/pages/comment_pages.dart';
import 'package:trilhapp/repository/posts/impl/post_dio_repository.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var postRepository = PostDioRepository();
  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    var lista = await postRepository.getPosts();
    setState(() {
      posts = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Postagens")),
            body: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (_, index) {
                  var post = posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return CommentPage(postId: post.id);
                      }));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Card(
                          child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Text(post.body,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      )),
                    ),
                  );
                })));
    // ListTile(
    //       title: Text(posts[index].title),
    //       subtitle: Text(posts[index].body))
  }
}
