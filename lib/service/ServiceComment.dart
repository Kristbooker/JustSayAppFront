import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment.dart';
import '../models/comments.dart';

class ServiceComment {
  static const String urls =
      "http://192.168.17.175:8080/api/comments/ownerUserId/";

  static Future<Comments> getComments(int userId) async {
    final url = "$urls$userId";

    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        // print(parsedFavorites(response.body));
        return parsedComments(response.body);
      } else {
        return Comments();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Comments();
    }
  }

  static const String urlp =
      "http://192.168.17.175:8080/api/comments/post/";

  static Future<Comments> getCommentsByPost(int postId) async {
    final url = "$urlp$postId";

    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        // print(parsedFavorites(response.body));
        return parsedComments(response.body);
      } else {
        return Comments();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Comments();
    }
  }

  static Future<bool> saveComment(Map<String, dynamic> commentData) async {
    final response = await http.post(
      Uri.parse('http://192.168.17.175:8080/api/comments/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commentData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save comment');
    }
  }

  

  

  static Comments parsedComments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Comment> comments =
        parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
    Comments p = Comments();
    p.comments = comments;
    return p;
  }
}