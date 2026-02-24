import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/vlc_client.dart' show client;
import '../models/playback_status.dart';
import 'dart:async';
import 'heartbeat_provider.dart';

export '../models/playback_status.dart';

final playbackStatusProvider = StreamProvider<PlaybackStatus>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getPlaybackStatusStream(),
    _ => Stream.value(PlaybackStatus.stopped),
  };
});
