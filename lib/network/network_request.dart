import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class NetWorkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/albums';

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
}
