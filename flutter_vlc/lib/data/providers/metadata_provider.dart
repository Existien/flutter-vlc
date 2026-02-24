import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/metadata.dart' show Metadata;
import '../services/vlc_client.dart' show client;
import 'dart:async';

import 'heartbeat_provider.dart';

final metadataProvider = StreamProvider<Metadata>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getMetadataStream(),
    _ => Stream.value(Metadata()),
  };
});
