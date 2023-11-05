import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justsaying/models/user.dart';

class ServiceUser {
  static const String urlu = "http://192.168.17.175:8080/api/users/update/";

  static Future<bool> updateUser(int userId, User updatedUser) async {
    final url = "$urlu$userId";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedUser.toJson()), 
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating user: ${e.toString()}');
      return false;
    }
  }

  static const String urls = "http://192.168.17.175:8080/api/users/";

  static Future<User> getUser(int userId) async {
    final url = "$urls$userId";

    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parsedUser(response.body);
      } else {
        return User();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return User();
    }
  }

  static User parsedUser(String responseBody) {
    final Map<String, dynamic>parsed = json.decode(responseBody);
    //final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
    final user = User.fromJson(parsed);
    return user;
  }
}
