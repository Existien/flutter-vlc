import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/playback_status_provider.dart';
import '../../services/vlc_client.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final playbackStatus =
            ref.watch(playbackStatusProvider).value ?? PlaybackStatus.stopped;
        return IconButton.outlined(
          onPressed: () async {
            switch (playbackStatus) {
              case PlaybackStatus.playing:
                await client.pause();
              default:
                await client.play();
            }
          },
          icon: Icon(switch (playbackStatus) {
            PlaybackStatus.playing => Icons.pause_outlined,
            _ => Icons.play_arrow_outlined,
          }),
        );
      },
    );
  }
}
