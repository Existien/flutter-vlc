import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/vlc_client.dart' show client;
import 'dart:async';

import 'heartbeat_provider.dart';

final shuffleProvider = StreamProvider<bool>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getShuffleStream(),
    _ => Stream.value(false),
  };
});
