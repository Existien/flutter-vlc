import 'package:flutter/material.dart';
import '../../../data/services/vlc_client.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton.outlined(
    onPressed: () async {
      await client.next();
    },
    icon: Icon(Icons.skip_next_outlined),
  );
}
