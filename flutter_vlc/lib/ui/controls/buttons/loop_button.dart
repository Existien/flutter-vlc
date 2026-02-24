import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/loop_status_provider.dart';
import '../../../data/services/vlc_client.dart';

class LoopButton extends StatelessWidget {
  const LoopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final loopStatus =
            ref.watch(loopStatusProvider).value ?? LoopStatus.none;
        return IconButton.outlined(
          onPressed: () async {
            var newStatus = switch (loopStatus) {
              LoopStatus.playList => LoopStatus.track,
              LoopStatus.track => LoopStatus.none,
              LoopStatus.none => LoopStatus.playList,
            };
            await client.setLoopStatus(newStatus);
          },
          icon: Icon(switch (loopStatus) {
            LoopStatus.playList => Icons.repeat_on_outlined,
            LoopStatus.track => Icons.repeat_one_on_outlined,
            LoopStatus.none => Icons.repeat_outlined,
          }),
        );
      },
    );
  }
}
