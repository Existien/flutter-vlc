import 'dart:async';
import 'package:dbus/dbus.dart';
import '../models/metadata.dart';
import '../models/loop_status.dart';
import '../models/playback_status.dart';
import 'interfaces/media_player2.dart';
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

  Stream<List<Metadata>> getTracksStream() {
    return () async* {
      yield await getTracks();
      if (_playerInterface != null) {
        yield* _playerInterface!.propertiesChanged
            .where((signal) => signal.invalidatedProperties.contains('Tracks'))
            .asyncMap((_) async {
              return await getTracks();
            })
            .handleError(print);
      }
    }();
  }

  Future<List<Metadata>> getTracks() async {
    final tracks =
        await _tryOrLog(() async => await _playerInterface?.getTracks()) ?? [];
    final metadata =
        await _tryOrLog(
          () async => await _playerInterface?.callGetTracksMetadata(tracks),
        ) ??
        [];
    return metadata
        .map(
          (entry) => entry.map((key, value) => MapEntry(key, value.toNative())),
        )
        .map((x) => _parseMetadata(x))
        .toList();
  }

  Stream<PlaybackStatus> getPlaybackStatusStream() {
    return () async* {
      yield await getPlaybackStatus();
      if (_playerInterface != null) {
        yield* _playerInterface!.propertiesChanged
            .where(
              (signal) =>
                  signal.changedProperties.containsKey('PlaybackStatus'),
            )
            .map((signal) {
              final status = signal.changedProperties['PlaybackStatus']!
                  .toNative();
              return PlaybackStatus.from(status);
            })
            .handleError(print);
      }
    }();
  }

  Future<PlaybackStatus> getPlaybackStatus() async {
    final status = await _tryOrLog(
      () async => await _playerInterface?.getPlaybackStatus(),
    );
    return PlaybackStatus.from(status ?? 'Stopped');
  }

  Stream<LoopStatus> getLoopStatusStream() {
    return () async* {
      yield await getLoopStatus();
      if (_playerInterface != null) {
        yield* _playerInterface!.propertiesChanged
            .where(
              (signal) => signal.changedProperties.containsKey('LoopStatus'),
            )
            .map((signal) {
              final status = signal.changedProperties['LoopStatus']!.toNative();
              return LoopStatus.from(status);
            })
            .handleError(print);
      }
    }();
  }

  Future<LoopStatus> getLoopStatus() async {
    final status = await _tryOrLog(
      () async => await _playerInterface?.getLoopStatus(),
    );
    return LoopStatus.from(status ?? 'None');
  }

  Future<void> setLoopStatus(LoopStatus status) async {
    await _tryOrLog(
      () async => await _playerInterface?.setLoopStatus(status.string),
    );
  }

  Stream<bool> getShuffleStream() {
    return () async* {
      yield await getShuffle();
      if (_playerInterface != null) {
        yield* _playerInterface!.propertiesChanged
            .where((signal) => signal.changedProperties.containsKey('Shuffle'))
            .map(
              (signal) =>
                  signal.changedProperties['Shuffle']!.toNative() as bool,
            )
            .handleError(print);
      }
    }();
  }

  Future<bool> getShuffle() async {
    return (await _tryOrLog(
          () async => await _playerInterface?.getShuffle(),
        )) ??
        false;
  }

  Future<void> setShuffle(bool shuffle) async {
    return await _tryOrLog(
      () async => await _playerInterface?.setShuffle(shuffle),
    );
  }

  Future<bool> isConnected() async {
    try {
      return await _appInterface?.getIdentity() != null;
    } on Exception {
      return false;
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

  Future<void> selectTrack(String trackid) async {
    await _tryOrLog(() async {
      await _playerInterface?.callGoTo(DBusObjectPath(trackid));
    });
  }

  Future<void> addTrack(String trackid, {bool playTrack = true}) async {
    await _tryOrLog(() async {
      await _playerInterface?.callAddTrack(
        trackid,
        DBusObjectPath('/org/videolan/vlc/playlist/0'),
        playTrack,
      );
    });
  }

  Future<void> removeTrack(String trackid) async {
    await _tryOrLog(() async {
      await _playerInterface?.callRemoveTrack(DBusObjectPath(trackid));
    });
  }

  Future<T?> _tryOrLog<T>(FutureOr<T> Function() function) async {
    try {
      return await function();
    } on Exception catch (e) {
      print(e);
      return null;
    } on Error catch (e) {
      print(e);
      rethrow;
    }
  }

  Metadata _parseMetadata(Map<String, dynamic> metadata) {
    return Metadata(
      album: metadata["xesam:album"],
      trackid: metadata["mpris:trackid"]?.value,
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
}
