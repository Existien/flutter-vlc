import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vlc/models/metadata.dart' show Metadata;
import './vlc_client.dart' show client;
import 'dart:async';

enum HeartbeatState { connected, disconnected }

final metadataProvider = StreamProvider<Metadata>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getMetadataStream(),
    _ => Stream.value(Metadata()),
  };
});

final heartbeatProvider = NotifierProvider(HeartbeatNotifier.new);

class HeartbeatNotifier extends Notifier<HeartbeatState> {
  @override
  HeartbeatState build() {
    final timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      state = await client.isConnected()
          ? HeartbeatState.connected
          : HeartbeatState.disconnected;
    });
    ref.onDispose(timer.cancel);
    return HeartbeatState.disconnected;
  }
}
