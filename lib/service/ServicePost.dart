import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/posts.dart';

class ServicePost {
  static const String url = "http://192.168.17.175:8080/api/posts/getAll";

  static Future<Posts> getPost() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
       // print(response.body);
        return parsedPosts(response.body);
      } else {
        return Posts();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Posts();
    }
  }

  static Future<bool> savePost(Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse('http://192.168.17.175:8080/api/posts/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save post');
    }
  }

  static Posts parsedPosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Post> posts = parsed.map<Post>((json) => Post.fromJson(json)).toList();
    Posts p = Posts();
    p.posts = posts;
    return p;
  }
}