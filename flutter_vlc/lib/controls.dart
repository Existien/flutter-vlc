import 'package:flutter/material.dart';
import 'controls/buttons.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      PlayButton(),
      Container(),
      PreviousButton(),
      StopButton(),
      NextButton(),
      Container(),
      LoopButton(),
      ShuffleButton(),
    ],
  );
}
