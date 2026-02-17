import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter_vlc/services/interfaces/media_player2.dart';
import '../models/metadata.dart';
import 'interfaces/media_player2_player.dart';

final client = VLCClient();

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
            .where(
              (signal) => (signal.changedProperties.containsKey("Metadata")),
            )
            .map((signal) {
              return _parseMetadata(
                ((signal.changedProperties["Metadata"] as DBusDict).toNative()
                        as Map<dynamic, dynamic>)
                    .map((key, value) => MapEntry<String, dynamic>(key, value)),
              );
            })
            .handleError(print);
      }
    }();
  }

  Future<Metadata> getMetadata() async {
    final parsed = await _tryOrLog(
      () async => await _playerInterface?.getMetadata(),
    );
    if (parsed == null) return Metadata();

    return _parseMetadata(
      parsed.map((key, value) => MapEntry(key, value.toNative())),
    );
  }

  Metadata _parseMetadata(Map<String, dynamic> metadata) {
    return Metadata(
      album: metadata["xesam:album"],
      trackid: metadata["mpris:trackid"]?.toString(),
      url: metadata["xesam:url"],
      title: metadata["xesam:title"],
      genre: List<String>.from(metadata["xesam:genre"] ?? []),
      artUrl: metadata["mpris:artUrl"],
      artist: List<String>.from(metadata["xesam:artist"] ?? []),
    );
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
