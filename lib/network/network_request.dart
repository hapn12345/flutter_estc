import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class NetWorkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/albums';
  static const String baseUrl = 'http://10.20.22.168:3033';
  static const String loginUrl = '$baseUrl/api/logins';

  List<Album> parseAlbum(String reponseBody) {
    var list = json.decode(reponseBody) as List<dynamic>;
    List<Album> albums = list.map((model) => Album.fromJson(model)).toList();
    return albums;
  }

  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(parseAlbum, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }

  Future<String> login(
    String userName,
    String password,
    VoidCallback onSuccess,
    VoidCallback onFailture,
  ) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Username': userName,
        'Password': password,
      }),
    );
    if (response.statusCode == 200) {
      onSuccess.call();
      return response.body;
    } else if (response.statusCode == 404) {
      onFailture.call();
      throw Exception('Wrong username or password');
    } else {
      throw Exception('Can\'t Login');
    }
  }
}
