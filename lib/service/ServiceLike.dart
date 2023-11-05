import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/like.dart';
import '../models/likes.dart';

class ServiceLike {
  static const String urls =
      "http://192.168.17.175:8080/api/liked/ownerUserId/";

  static Future<Likes> getLikes(int userId) async {
    final url = "$urls$userId";

    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parsedLikes(response.body);
      } else {
        return Likes();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Likes();
    }
  }

  static const String url = "http://192.168.17.175:8080/api/liked/post/";

  static Future<int> getLikesCount(int postId) async {
  final urlString = "$url$postId";
  try {
    final response = await http.get(Uri.parse(urlString));
    if (response.statusCode == 200) {
      final responseBody = response.body.trim(); // Trim any surrounding whitespace
      final likeCount = int.tryParse(responseBody); // Use tryParse to handle non-integer values safely.
      if (likeCount != null) {
        return likeCount;
      } else {
        print('Response does not contain an integer: $responseBody');
        return 0;
      }
    } else {
      print('Server error: ${response.statusCode}');
      return 0;
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    return 0;
  }
}

  static Future<bool> saveLike(Map<String, dynamic> likeData) async {
    final response = await http.post(
      Uri.parse('http://192.168.17.175:8080/api/liked/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(likeData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save like');
    }
  }

  static Likes parsedLikes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Like> likes = parsed.map<Like>((json) => Like.fromJson(json)).toList();
    Likes p = Likes();
    p.likes = likes;
    return p;
  }
}
