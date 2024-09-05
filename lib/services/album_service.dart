import 'dart:convert';

import 'package:app/models/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/albums/1/photos';

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      // Map the list to a list of AlbumPhoto objects
    print(body);
      List<Album> photos =
          body.map((dynamic item) => Album.fromJson(item)).toList();

      return photos;
    } else {
      throw Exception('Failed to load album photos');
    }
  }
}
