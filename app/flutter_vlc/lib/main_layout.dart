import 'package:flutter/material.dart';
import 'controls.dart';
import 'info.dart';
import 'playlist.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: PlayList()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Info(),
              Controls(),
            ],
          ),
        ),
      ],
    );
  }
}
