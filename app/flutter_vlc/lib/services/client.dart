import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vlc/services/interfaces/media_player2.dart';

import 'interfaces/media_player2_player.dart';

class Metadata {
  final String album;
  final DBusObjectPath? trackid;
  final String? url;
  final String title;
  final List<String> genre;
  final List<String> artist;
  final String? artUrl;
  Metadata({
    this.album = "n/a",
    this.trackid,
    this.url = "n/a",
    this.title = "n/a",
    this.genre = const [],
    this.artist = const [],
    this.artUrl,
  });
}

final metadataProvider = StreamProvider<Metadata>((ref) {
  final heartbeat = ref.watch(heartbeatProvider);
  return switch (heartbeat) {
    HeartbeatState.connected => client.getMetadataStream(),
    _ => Stream.value(Metadata()),
  };
});

final heartbeatProvider = NotifierProvider(HeartbeatNotifier.new);

enum HeartbeatState { connected, disconnected }

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

class VLCClient {
  DBusClient? _client;
  OrgMprisMediaPlayer2? __appInterface;
  OrgMprisMediaPlayer2? get _appInterface {
    if (__appInterface == null) _connect();
    return __appInterface;
  }

  OrgMprisMediaPlayer2Player? __playerInterface;
  OrgMprisMediaPlayer2Player? get _playerInterface {
    if (__playerInterface == null) _connect();
    return __playerInterface;
  }

  Stream<Metadata> getMetadataStream() {
    return () async* {
      yield await getMetadata();
      if (_playerInterface != null) {
        yield* _playerInterface!.propertiesChanged
            .handleError(print)
            .where(
              (signal) => (signal.changedProperties.containsKey("Metadata")),
            )
            .map((signal) {
              final parsed = (signal.changedProperties["Metadata"] as DBusDict)
                  .toNative();
              return Metadata(
                album: parsed["xesam:album"],
                trackid: parsed["mpris:trackid"],
                url: parsed["xesam:url"],
                title: parsed["xesam:title"],
                genre: List<String>.from(parsed["xesam:genre"]),
                artUrl: parsed["mpris:artUrl"],
                artist: List<String>.from(parsed["xesam:artist"]),
              );
            });
      }
    }();
  }

  Future<Metadata> getMetadata() async {
    final parsed = await _tryOrLog(
      () async => await _playerInterface?.getMetadata(),
    );
    return switch (parsed) {
      Map<String, DBusValue> parsed => Metadata(
        album: parsed["xesam:album"]?.toNative(),
        trackid: parsed["mpris:trackid"]?.toNative(),
        url: parsed["xesam:url"]?.toNative(),
        title: parsed["xesam:title"]?.toNative(),
        genre: List<String>.from(parsed["xesam:genre"]?.toNative()),
        artUrl: parsed["mpris:artUrl"]?.toNative(),
        artist: List<String>.from(parsed["xesam:artist"]?.toNative()),
      ),
      _ => Metadata(),
    };
  }

  void _connect() {
    _client = DBusClient.session();
    __playerInterface = OrgMprisMediaPlayer2Player(
      _client!,
      "org.mpris.MediaPlayer2.vlc",
      DBusObjectPath("/org/mpris/MediaPlayer2"),
    );
    __appInterface = OrgMprisMediaPlayer2(
      _client!,
      "org.mpris.MediaPlayer2.vlc",
      DBusObjectPath("/org/mpris/MediaPlayer2"),
    );
  }

  Future<bool> isConnected() async {
    try {
      return await _appInterface?.getIdentity() != null;
    } on Exception {
      return false;
    }
  }

  Future<T?> _tryOrLog<T>(FutureOr<T> Function() function) async {
    try {
      return await function();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> play() async {
    await _tryOrLog(() async {
      await _playerInterface?.callPlay();
    });
  }

  Future<void> pause() async {
    await _tryOrLog(() async {
      await _playerInterface?.callPause();
    });
  }

  Future<void> next() async {
    await _tryOrLog(() async {
      await _playerInterface?.callNext();
    });
  }

  Future<void> stop() async {
    await _tryOrLog(() async {
      await _playerInterface?.callStop();
    });
  }

  Future<void> previous() async {
    await _tryOrLog(() async {
      await _playerInterface?.callPrevious();
    });
  }
}

final client = VLCClient();
