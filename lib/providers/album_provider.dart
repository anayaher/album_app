import 'package:app/models/album.dart';
import 'package:app/services/album_service.dart';
import 'package:flutter/material.dart';

class AlbumProvider with ChangeNotifier {
  List<Album> _photos = [];
  AlbumService _apiService = AlbumService();

//getters
  List<Album> get photos => _photos;

  Future<void> fetchAlbumPhotos() async {
    try {
      _photos = await _apiService.fetchAlbums();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //user added
  void addPhoto(Album album) {
    _photos.insert(0, album); // Add new album to the top
    notifyListeners();
  }

  void updateAlbum(Album updatedAlbum) {
    final index = _photos.indexWhere((album) => album.id == updatedAlbum.id);
    if (index != -1) {
      _photos[index] = updatedAlbum;
      notifyListeners();
    }
  }
}
