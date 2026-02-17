import 'package:flutter/material.dart';
import '../../services/vlc_client.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton.outlined(
    onPressed: () async {
      await client.previous();
    },
    icon: Icon(Icons.skip_previous_outlined),
  );
}
