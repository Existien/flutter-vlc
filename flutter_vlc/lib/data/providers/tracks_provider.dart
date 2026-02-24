import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/metadata.dart' show Metadata;
import '../services/vlc_client.dart' show client;
import 'dart:async';

import 'heartbeat_provider.dart';

final tracksProvider = AsyncNotifierProvider(() => TracksNotifier());

class TracksNotifier extends AsyncNotifier<List<Metadata>> {
  @override
  Future<List<Metadata>> build() async {
    final heartbeat = ref.watch(heartbeatProvider);
    if (heartbeat == HeartbeatState.disconnected) return <Metadata>[];
    client.getTracksStream().listen((tracks) {
      state = AsyncValue.data(tracks);
      ref.notifyListeners();
    });
    return client.getTracksStream().last;
  }
}
