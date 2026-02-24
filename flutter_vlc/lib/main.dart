import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/main_layout.dart';
import 'dart:io';

void main() async {
  await Process.start("vlc_backend", [pid.toString()], mode: ProcessStartMode.detached);
  ProcessSignal.sigint.watch().listen((_) => print("SIGINT"));
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
