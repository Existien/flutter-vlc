import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playlist/track.dart';
import 'services/tracks_provider.dart';
import 'services/vlc_client.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  static const initialPath = 'file:///workspaces/';
  final _controller = TextEditingController(text: initialPath);
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) {
        final tracks = ref.watch(tracksProvider).value;
        return Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            spacing: 10,
            children: [
              for (var entry in tracks ?? []) Track(metadata: entry),
              Container(),
              TextField(
                autofocus: true,
                focusNode: _focusNode,
                controller: _controller,
                onSubmitted: (_) async {
                  await client.addTrack(_controller.text);
                  _controller.clear();
                  _controller.text = initialPath;
                  _focusNode.requestFocus();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
