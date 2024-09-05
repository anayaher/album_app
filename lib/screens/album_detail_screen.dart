import 'package:app/models/album.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/album_provider.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailsScreen({super.key, required this.album});

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _urlController;
  bool _isEditing = false; // State variable to toggle editing mode

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.album.title);
    _urlController = TextEditingController(text: widget.album.thumbnailUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);

    final updatedAlbum = Album(
      id: widget.album.id,
      albumId: widget.album.albumId,
      title: _titleController.text,
      url: _urlController.text,
      thumbnailUrl: _urlController.text,
    );

    albumProvider.updateAlbum(updatedAlbum);
    Navigator.pop(context, true); // Signal that changes were made
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEditing,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.blue),
              child: Text(
                'ID: ${widget.album.id}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Image.network(
                widget.album.thumbnailUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
              enabled: _isEditing, // Enable or disable based on editing mode
            ),
            const SizedBox(height: 16.0),
            Text(
              'Cover URL:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter image URL',
              ),
              enabled: _isEditing, // Enable or disable based on editing mode
            ),
            const SizedBox(height: 16.0),
            Text(
              'Image URL :',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              widget.album.url,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.blue),
            ),
            const Spacer(),
            if (_isEditing) // Show the save button only when editing

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveChanges,
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
