import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/favorite.dart';
import '../models/favorites.dart';

class ServiceFavorite {
  static const String urls =
      "http://192.168.17.175:8080/api/favorites/getFavByUser/";

  static Future<Favorites> getFavorite(int userId) async {
    final url = "$urls$userId";

    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        // print(parsedFavorites(response.body));
        return parsedFavorites(response.body);
      } else {
        return Favorites();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Favorites();
    }
  }

  static const String urld = "http://192.168.17.175:8080/api/favorites/delete/";

  static Future<bool> deleteFavorite(int favoriteId) async {
    final url = "$urld$favoriteId";

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 204) {
        // สมมติว่าการลบสำเร็จเมื่อ server ตอบกลับด้วย 200 OK หรือ 204 No Content
        return true;
      } else {
        // Handle different status codes differently here
        print('Failed to delete favorite: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting favorite: ${e.toString()}');
      return false;
    }
  }

  static Future<bool> saveFavorite(Map<String, dynamic> favoriteData) async {
    final response = await http.post(
      Uri.parse('http://192.168.17.175:8080/api/favorites/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(favoriteData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save favorite');
    }
  }

  static Favorites parsedFavorites(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Favorite> favorites =
        parsed.map<Favorite>((json) => Favorite.fromJson(json)).toList();
    Favorites p = Favorites();
    p.favorites = favorites;
    return p;
  }
}
