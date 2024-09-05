import 'package:app/providers/album_provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/screens/album_list_screen.dart';
import 'package:app/theme/dark_theme.dart';

import 'package:app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlbumProvider(),
        ),
      ],
      child: const MyApp(), // Wrap MyApp with MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        title: 'Album App',
        theme: themeNotifier.currentTheme,
        home: const AlbumListScreen(),
      );
    });
  }
}
