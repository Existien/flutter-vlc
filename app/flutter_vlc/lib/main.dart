import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.dark(),
          appBarTheme: AppBarTheme(elevation: 5),
        ),
        home: Scaffold(
          appBar: AppBar(title: Text("Flutter VLC")),
          body: Center(child: MainLayout()),
        ),
      ),
    );
  }
}
