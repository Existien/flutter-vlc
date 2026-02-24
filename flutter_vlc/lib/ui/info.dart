import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/providers/metadata_provider.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) {
        final metadata = ref.watch(metadataProvider).value;
        return Column(
          children: [
            Text(
              metadata?.title ??
                  (metadata?.url != null
                      ? Uri.parse(metadata?.url ?? "None").pathSegments.last
                      : ""),
            ),
            Text(metadata?.album ?? ""),
            Text((metadata?.artist ?? [""]).join(", ")),
            Text((metadata?.genre ?? [""]).join(", ")),
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
