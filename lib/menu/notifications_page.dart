import 'package:flutter/material.dart';
import 'package:justsaying/models/comments.dart';
import 'package:justsaying/service/ServiceLike.dart';
import 'package:justsaying/service/ServiceComment.dart';

import '../models/likes.dart';

class NotificationsPage extends StatefulWidget {
  final int userId;
  const NotificationsPage({Key? key, required int this.userId})
      : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPage();
}

class _NotificationsPage extends State<NotificationsPage> {
  late Likes likes;
  late Comments comments;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    likes = Likes();
    comments = Comments();
    isLoading = true;

    ServiceLike.getLikes(widget.userId).then((likeFromServer) {
      setState(() {
        likes = likeFromServer;
        isLoading = false;
      });
    });

    ServiceComment.getComments(widget.userId).then((commentFromServer) {
      setState(() {
        comments = commentFromServer;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 34, 31, 35),
        title: Text('Notifications'),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[listLike(), listComments()],
              ),
      ),
    );
  }

  Widget listLike() {
    return Expanded(
        child: ListView.builder(
      itemCount: likes.likes == null ? 0 : likes.likes.length,
      itemBuilder: (BuildContext context, int index) {
        return rowLikes(index);
      },
    ));
  }

  Widget rowLikes(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(likes.likes[index].user.proImg),
            ),
            SizedBox(
                width: 10), // Give some space between the avatar and the text
            Expanded(
              // Use Expanded to ensure the text takes up the remaining space
              child: Text(
                "${likes.likes[index].user.userName} Liked your post (${likes.likes[index].post.id})",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //comment
  Widget listComments() {
    return Expanded(
        child: ListView.builder(
      itemCount: comments.comments == null ? 0 : comments.comments.length,
      itemBuilder: (BuildContext context, int index) {
        return rowComment(index);
      },
    ));
  }

  Widget rowComment(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  NetworkImage(comments.comments[index].user.proImg),
            ),
            SizedBox(
                width: 10), // Give some space between the avatar and the text
            Expanded(
              // Use Expanded to ensure the text takes up the remaining space
              child: Text(
                "${comments.comments[index].user.userName} Commented your post (${comments.comments[index].post.id})",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
