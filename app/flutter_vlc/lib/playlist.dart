import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final List<String> _playlist = [];
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var entry in _playlist) Text(entry),
        TextField(
          autofocus: true,
          focusNode: _focusNode,
          controller: _controller,
          onSubmitted: (_) {
            setState(() {
              _playlist.add(_controller.text);
            });
            _controller.clear();
            _focusNode.requestFocus();
          },
        ),
      ],
    );
  }
}
