import 'package:flutter_riverpod/flutter_riverpod.dart';
import './vlc_client.dart' show client;
import '../models/loop_status.dart';
import 'dart:async';
import 'heartbeat_provider.dart';

export '../models/loop_status.dart';

final loopStatusProvider = StreamProvider<LoopStatus>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getLoopStatusStream(),
    _ => Stream.value(LoopStatus.none),
  };
});
