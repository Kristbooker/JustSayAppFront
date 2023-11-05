import 'package:flutter/material.dart';
import 'package:justsaying/models/index.dart';
import 'package:justsaying/service/ServiceComment.dart';
import 'package:justsaying/service/ServiceLike.dart';
import 'package:justsaying/service/ServicePost.dart';
import '../models/posts.dart';
import '../service/ServiceFavorite.dart';

class FeedsPage extends StatefulWidget {
  final int userId;
  const FeedsPage({Key? key, required int this.userId}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  //late Products products;
  late Posts posts;
  late String title;
  late Comments comments;
  bool isLoading = false;
  Map<int, int> likesCountMap = {};

  @override
  void initState() {
    super.initState();
    posts = Posts();
    isLoading = true;

    ServicePost.getPost().then((postFromServer) {
      setState(() {
        posts = postFromServer;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.feed,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Post"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: "Post here",
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Post"),
                        onPressed: () {
                          final post = {
                            "user": {
                              "id": widget
                                  .userId // สมมติว่า ID นี้คือ ID ของ user ที่กำลังทำการโพสต์
                            },
                            "content":
                                textController.text // ข้อความที่ได้รับจาก input
                          };
                          String cardContent = textController.text;
                          print("บันทึก Card: $cardContent");
                          Navigator.of(context).pop();
                          ServicePost.savePost(post).then((result) {
                            print("Post was saved: $result");
                            Navigator.of(context).pop(); // ปิด AlertDialog
                          }).catchError((error) {
                            // จัดการกับข้อผิดพลาดที่นี่
                            print("Failed to save the post: $error");
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        title: Text('Feeds'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 34, 31, 35),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  listFeeds(),
                ],
              ),
      ),
    );
  }

  Widget listFeeds() {
    final TextEditingController textController = TextEditingController();
    final postList = posts.posts ?? [];

    return Expanded(
      child: ListView.separated(
        itemCount: posts.posts == null ? 0 : posts.posts.length,
        // itemCount: postList.length,
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemBuilder: (BuildContext context, int index) {
          // final reversedIndex = postList.length - 1 - index;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row(index),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {
                      final like = {
                        "user": {"id": widget.userId},
                        "post": {"id": posts.posts[index].id}
                      };
                      // print(posts.posts[index].id);

                      ServiceLike.saveLike(like).then((result) {
                        print("Like was saved: $result");
                        Navigator.of(context).pop(); // ปิด AlertDialog
                      }).catchError((error) {
                        // จัดการกับข้อผิดพลาดที่นี่
                        print("Failed to save the Like: $error");
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Comment"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    hintText: "Comment here",
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Comment"),
                                onPressed: () {
                                  final comment = {
                                    "user": {"id": widget.userId},
                                    "post": {"id": posts.posts[index].id},
                                    "content": textController
                                        .text // ข้อความที่ได้รับจาก input
                                  };
                                  // print(posts.posts[index].id);
                                  String cardContent = textController.text;
                                  print("บันทึก คอมเม้น: $cardContent");
                                  Navigator.of(context).pop();
                                  ServiceComment.saveComment(comment)
                                      .then((result) {
                                    print("Comment was saved: $result");
                                    Navigator.of(context)
                                        .pop(); // ปิด AlertDialog
                                  }).catchError((error) {
                                    // จัดการกับข้อผิดพลาดที่นี่
                                    print("Failed to save the Comment: $error");
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      final favorite = {
                        "user": {"id": widget.userId},
                        "post": {"id": posts.posts[index].id}
                      };
                      // print(posts.posts[index].id);

                      ServiceFavorite.saveFavorite(favorite).then((result) {
                        print("Like was saved: $result");
                        Navigator.of(context).pop(); // ปิด AlertDialog
                      }).catchError((error) {
                        // จัดการกับข้อผิดพลาดที่นี่
                        print("Failed to save the Like: $error");
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget row(int index) {
    // var postId = posts.posts[index].id;
    // var likesCount = likesCountMap[postId];
    var likeCounts = ServiceLike.getLikesCount(posts.posts[index].id.toInt());
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FutureBuilder<Comments>(
              future: ServiceComment.getCommentsByPost(
                  posts.posts[index].id.toInt()),
              builder:
                  (BuildContext context, AsyncSnapshot<Comments> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AlertDialog(
                    content: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final comments = snapshot.data?.comments ?? [];
                  return AlertDialog(
                    title: Text('Comments'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        // แสดงรายการ comments พร้อมรูปภาพและ username
                        children: comments.map((comment) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(comment.user.proImg),
                            ),
                            title: Text(comment.user.userName),
                            subtitle: Text(comment.content),
                          );
                        }).toList(),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                } else {
                  return AlertDialog(
                    content: Text('No comments found.'),
                  );
                }
              },
            );
          },
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(posts.posts[index].user.proImg),
          ),
          title: Text(
            posts.posts[index].user.userName,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts.posts[index].content,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          trailing: FutureBuilder<int>(
            future: ServiceLike.getLikesCount(posts.posts[index].id.toInt()),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle the error state
                return Text('Error');
              } else if (snapshot.hasData) {
                // When data is received, display the likes count
                return Text('${snapshot.data} Likes');
              } else {
                // Handle the case where there is no data (although this should not happen)
                return Text('0 Likes');
              }
            },
          ),
        ),
      ),
    );
  }
}
