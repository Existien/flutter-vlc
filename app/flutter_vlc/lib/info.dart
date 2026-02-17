import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './services/heartbeat_provider.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) {
        final metadata = ref.watch(metadataProvider).value;
        return Column(
          children: [
            Text(metadata?.title ?? metadata?.url ?? "n/a"),
            Text(metadata?.album ?? "n/a"),
            Text((metadata?.artist ?? ["n/a"]).join(", ")),
            Text((metadata?.genre ?? ["n/a"]).join(", ")),
            if (metadata?.artUrl != null)
              Image.file(
                File.fromUri(Uri.parse(metadata!.artUrl!)),
                height: 300,
              ),
          ],
        );
      },
    );
  }
}
