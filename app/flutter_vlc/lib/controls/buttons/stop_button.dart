import 'package:flutter/material.dart';
import '../../services/vlc_client.dart';

class StopButton extends StatelessWidget {
  const StopButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton.outlined(
    onPressed: () async {
      await client.stop();
    },
    icon: Icon(Icons.stop_outlined),
  );
}
