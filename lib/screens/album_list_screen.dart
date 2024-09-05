import 'package:app/models/album.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/screens/add_album_screen.dart';
import 'package:app/screens/album_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/album_provider.dart';
import 'package:app/widgets/album_card.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  void toggleTheme() {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    themeProvider.toggleTheme();
  }

  void _navigateToDetails(Album album) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetailsScreen(album: album),
      ),
    );

    if (result == true) {
      setState(() {}); // Refresh the list if changes were saved
    }
  }

  @override
  void initState() {
    super.initState();

    // Only fetch the album list if it's currently empty
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    if (albumProvider.photos.isEmpty) {
      albumProvider.fetchAlbumPhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Album List Page",
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.brightness_6), onPressed: toggleTheme),
        ],
      ),
      body: Consumer<AlbumProvider>(
        builder: (context, albumProvider, child) {
          // Show loading spinner if data is still loading
          if (albumProvider.photos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Otherwise, display the list of albums using the AlbumCard widget
          return ListView.builder(
            itemCount: albumProvider.photos.length,
            itemBuilder: (context, index) {
              final albumPhoto = albumProvider.photos[index];
              return AlbumCard(
                onClick: () => _navigateToDetails(albumPhoto),
                themeData: theme,
                album: albumPhoto,
                thumbnailUrl: albumPhoto.thumbnailUrl,
              );
            },
          );
        },
      ),
      // Add Floating Action Button to navigate to the "Add Album" screen
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddAlbumScreen

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddAlbumScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
