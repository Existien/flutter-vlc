import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vlc/services/client.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) => Column(
        children: [
          Text(ref.watch(metadataProvider).value?.title??"n/a"),
          Text(ref.watch(metadataProvider).value?.album??"n/a"),
          Text((ref.watch(metadataProvider).value?.artist??["n/a"]).join(", ")),
          Text((ref.watch(metadataProvider).value?.genre??["n/a"]).join(", ")),
          if (ref.watch(metadataProvider).value?.artUrl != null)
            Image.file(
              File.fromUri(Uri.parse(ref.watch(metadataProvider).value!.artUrl!)),
              height: 300,
            ),
        ],
      ),
    );
  }
}
