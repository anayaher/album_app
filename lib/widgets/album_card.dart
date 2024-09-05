import 'package:app/models/album.dart';

import 'package:flutter/material.dart';


class AlbumCard extends StatelessWidget {
  final ThemeData themeData;
  final Album album;
  final VoidCallback onClick;

  final String thumbnailUrl;
  const AlbumCard({
    super.key,
    required this.themeData,
    required this.thumbnailUrl,
    required this.album,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: themeData.cardColor,
          elevation: 4, // Increased elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for image
                  child: Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      if (frame == null) {
                        return const Center(
                            child: SizedBox(
                          height: 150,
                        ));
                      }
                      
                      return child;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    style: Theme.of(context).textTheme.bodyLarge,
                    album.title,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
