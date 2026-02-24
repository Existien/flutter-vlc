import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/metadata_provider.dart';
import '../../data/providers/playback_status_provider.dart';
import '../../data/models/metadata.dart';
import '../../data/services/vlc_client.dart';

class Track extends StatelessWidget {
  const Track({super.key, this.metadata});
  final Metadata? metadata;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isCurrentTrack =
            ref.watch(metadataProvider).value?.trackid == metadata?.trackid;
        final playbackStatus =
            ref.watch(playbackStatusProvider).value ?? PlaybackStatus.stopped;
        return GestureDetector(
          onTap: () async {
            if (metadata?.trackid != null) {
              await client.selectTrack(metadata!.trackid!);
            }
          },
          child: Container(
            color: isCurrentTrack
                ? Theme.of(context).highlightColor
                : Theme.of(context).primaryColor,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    metadata?.title ??
                        Uri.parse(metadata?.url ?? "n/a").pathSegments.last,
                  ),
                ),
                if (metadata?.trackid != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () async {
                        final isPlaying =
                            playbackStatus == PlaybackStatus.playing &&
                            isCurrentTrack;
                        await client.removeTrack(metadata!.trackid!);
                        if (isPlaying) await client.play();
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
