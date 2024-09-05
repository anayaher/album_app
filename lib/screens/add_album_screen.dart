import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/album_provider.dart';
import 'package:app/models/album.dart';

class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({super.key});

  @override
  State<AddAlbumScreen> createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _coverUrlController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  void _saveAlbum() {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);

    // Calculate the next available ID based on the existing list
    final nextId = albumProvider.photos.isEmpty
        ? 1
        : albumProvider.photos
                .map((album) => album.id)
                .reduce((a, b) => a > b ? a : b) +
            1;

    final newAlbum = Album(
      id: nextId, // Use the calculated ID
      albumId: 1, // Assuming albumId for this demo
      title: _titleController.text,
      url: _urlController.text,
      thumbnailUrl: _coverUrlController.text,
    );

    albumProvider.addPhoto(newAlbum);
    Navigator.pop(context,
        true); // Return to the previous screen and signal that changes were made
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Album'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Title:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter album title',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Cover URL:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: _coverUrlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Cover URL',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Image URL:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Image URL',
              ),
            ),
            if (_urlController
                .text.isNotEmpty) // Show preview only if URL is entered
              Image.network(
                _urlController.text,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveAlbum,
                    child: const Text('Save Changes'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
