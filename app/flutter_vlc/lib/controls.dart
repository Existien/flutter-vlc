import 'package:flutter/material.dart';
import 'services/vlc_client.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        IconButton.outlined(
          onPressed: () async {
            await client.previous();
          },
          icon: Icon(Icons.skip_previous),
        ),
        IconButton.outlined(
          onPressed: () async {
            await client.play();
          },
          icon: Icon(Icons.play_arrow),
        ),
        IconButton.outlined(
          onPressed: () async {
            await client.pause();
          },
          icon: Icon(Icons.pause),
        ),
        IconButton.outlined(
          onPressed: () async {
            await client.stop();
          },
          icon: Icon(Icons.stop),
        ),
        IconButton.outlined(
          onPressed: () async {
            await client.next();
          },
          icon: Icon(Icons.skip_next),
        ),
      ],
    );
  }
}
