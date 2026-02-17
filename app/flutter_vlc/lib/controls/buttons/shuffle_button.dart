import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/shuffle_provider.dart';
import '../../services/vlc_client.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final shuffle = ref.watch(shuffleProvider).value ?? false;
        return IconButton.outlined(
          onPressed: () async {
            await client.setShuffle(!shuffle);
          },
          icon: Icon(
            shuffle ? Icons.shuffle_on_outlined : Icons.shuffle_outlined,
          ),
        );
      },
    );
  }
}
