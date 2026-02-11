// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object vlc.dbus.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

/// Signal data for org.mpris.MediaPlayer2.TrackList.TrackListReplaced.
class OrgMprisMediaPlayer2PlayerTrackListReplaced extends DBusSignal {
  List<DBusObjectPath> get arg_0 => values[0].asObjectPathArray().toList();
  DBusObjectPath get arg_1 => values[1].asObjectPath();

  OrgMprisMediaPlayer2PlayerTrackListReplaced(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.mpris.MediaPlayer2.TrackList.TrackAdded.
class OrgMprisMediaPlayer2PlayerTrackAdded extends DBusSignal {
  Map<String, DBusValue> get arg_0 => values[0].asStringVariantDict();
  DBusObjectPath get arg_1 => values[1].asObjectPath();

  OrgMprisMediaPlayer2PlayerTrackAdded(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.mpris.MediaPlayer2.TrackList.TrackRemoved.
class OrgMprisMediaPlayer2PlayerTrackRemoved extends DBusSignal {
  DBusObjectPath get arg_0 => values[0].asObjectPath();

  OrgMprisMediaPlayer2PlayerTrackRemoved(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.mpris.MediaPlayer2.TrackList.TrackMetadataChanged.
class OrgMprisMediaPlayer2PlayerTrackMetadataChanged extends DBusSignal {
  DBusObjectPath get arg_0 => values[0].asObjectPath();
  Map<String, DBusValue> get arg_1 => values[1].asStringVariantDict();

  OrgMprisMediaPlayer2PlayerTrackMetadataChanged(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgMprisMediaPlayer2Player extends DBusRemoteObject {
  /// Stream of org.mpris.MediaPlayer2.TrackList.TrackListReplaced signals.
  late final Stream<OrgMprisMediaPlayer2PlayerTrackListReplaced> trackListReplaced;

  /// Stream of org.mpris.MediaPlayer2.TrackList.TrackAdded signals.
  late final Stream<OrgMprisMediaPlayer2PlayerTrackAdded> trackAdded;

  /// Stream of org.mpris.MediaPlayer2.TrackList.TrackRemoved signals.
  late final Stream<OrgMprisMediaPlayer2PlayerTrackRemoved> trackRemoved;

  /// Stream of org.mpris.MediaPlayer2.TrackList.TrackMetadataChanged signals.
  late final Stream<OrgMprisMediaPlayer2PlayerTrackMetadataChanged> trackMetadataChanged;

  OrgMprisMediaPlayer2Player(DBusClient client, String destination, DBusObjectPath path) : super(client, name: destination, path: path) {
    trackListReplaced = DBusRemoteObjectSignalStream(object: this, interface: 'org.mpris.MediaPlayer2.TrackList', name: 'TrackListReplaced', signature: DBusSignature('aoo')).asBroadcastStream().map((signal) => OrgMprisMediaPlayer2PlayerTrackListReplaced(signal));

    trackAdded = DBusRemoteObjectSignalStream(object: this, interface: 'org.mpris.MediaPlayer2.TrackList', name: 'TrackAdded', signature: DBusSignature('a{sv}o')).asBroadcastStream().map((signal) => OrgMprisMediaPlayer2PlayerTrackAdded(signal));

    trackRemoved = DBusRemoteObjectSignalStream(object: this, interface: 'org.mpris.MediaPlayer2.TrackList', name: 'TrackRemoved', signature: DBusSignature('o')).asBroadcastStream().map((signal) => OrgMprisMediaPlayer2PlayerTrackRemoved(signal));

    trackMetadataChanged = DBusRemoteObjectSignalStream(object: this, interface: 'org.mpris.MediaPlayer2.TrackList', name: 'TrackMetadataChanged', signature: DBusSignature('oa{sv}')).asBroadcastStream().map((signal) => OrgMprisMediaPlayer2PlayerTrackMetadataChanged(signal));
  }

  /// Gets org.mpris.MediaPlayer2.Player.Metadata
  Future<Map<String, DBusValue>> getMetadata() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'Metadata', signature: DBusSignature('a{sv}'));
    return value.asStringVariantDict();
  }

  /// Gets org.mpris.MediaPlayer2.Player.PlaybackStatus
  Future<String> getPlaybackStatus() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'PlaybackStatus', signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.mpris.MediaPlayer2.Player.LoopStatus
  Future<String> getLoopStatus() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'LoopStatus', signature: DBusSignature('s'));
    return value.asString();
  }

  /// Sets org.mpris.MediaPlayer2.Player.LoopStatus
  Future<void> setLoopStatus (String value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'LoopStatus', DBusString(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.Volume
  Future<double> getVolume() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'Volume', signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Sets org.mpris.MediaPlayer2.Player.Volume
  Future<void> setVolume (double value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'Volume', DBusDouble(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.Shuffle
  Future<double> getShuffle() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'Shuffle', signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Sets org.mpris.MediaPlayer2.Player.Shuffle
  Future<void> setShuffle (double value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'Shuffle', DBusDouble(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.Position
  Future<int> getPosition() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'Position', signature: DBusSignature('i'));
    return value.asInt32();
  }

  /// Gets org.mpris.MediaPlayer2.Player.Rate
  Future<double> getRate() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'Rate', signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Sets org.mpris.MediaPlayer2.Player.Rate
  Future<void> setRate (double value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'Rate', DBusDouble(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.MinimumRate
  Future<double> getMinimumRate() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'MinimumRate', signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Sets org.mpris.MediaPlayer2.Player.MinimumRate
  Future<void> setMinimumRate (double value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'MinimumRate', DBusDouble(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.MaximumRate
  Future<double> getMaximumRate() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'MaximumRate', signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Sets org.mpris.MediaPlayer2.Player.MaximumRate
  Future<void> setMaximumRate (double value) async {
    await setProperty('org.mpris.MediaPlayer2.Player', 'MaximumRate', DBusDouble(value));
  }

  /// Gets org.mpris.MediaPlayer2.Player.CanControl
  Future<bool> getCanControl() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'CanControl', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.mpris.MediaPlayer2.Player.CanPlay
  Future<bool> getCanPlay() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'CanPlay', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.mpris.MediaPlayer2.Player.CanPause
  Future<bool> getCanPause() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'CanPause', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.mpris.MediaPlayer2.Player.CanSeek
  Future<bool> getCanSeek() async {
    var value = await getProperty('org.mpris.MediaPlayer2.Player', 'CanSeek', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Previous()
  Future<void> callPrevious({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Previous', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Next()
  Future<void> callNext({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Next', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Stop()
  Future<void> callStop({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Stop', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Play()
  Future<void> callPlay({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Play', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Pause()
  Future<void> callPause({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Pause', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.PlayPause()
  Future<void> callPlayPause({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'PlayPause', [], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.Seek()
  Future<void> callSeek(int arg_0, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'Seek', [DBusInt64(arg_0)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.OpenUri()
  Future<void> callOpenUri(String arg_0, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'OpenUri', [DBusString(arg_0)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.Player.SetPosition()
  Future<void> callSetPosition(DBusObjectPath arg_0, int arg_1, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.Player', 'SetPosition', [arg_0, DBusInt64(arg_1)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Gets org.mpris.MediaPlayer2.TrackList.Tracks
  Future<List<DBusObjectPath>> getTracks() async {
    var value = await getProperty('org.mpris.MediaPlayer2.TrackList', 'Tracks', signature: DBusSignature('ao'));
    return value.asObjectPathArray().toList();
  }

  /// Gets org.mpris.MediaPlayer2.TrackList.CanEditTracks
  Future<bool> getCanEditTracks() async {
    var value = await getProperty('org.mpris.MediaPlayer2.TrackList', 'CanEditTracks', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Invokes org.mpris.MediaPlayer2.TrackList.GetTracksMetadata()
  Future<List<Map<String, DBusValue>>> callGetTracksMetadata(List<DBusObjectPath> arg_0, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.mpris.MediaPlayer2.TrackList', 'GetTracksMetadata', [DBusArray.objectPath(arg_0)], replySignature: DBusSignature('aa{sv}'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asArray().map((child) => child.asStringVariantDict()).toList();
  }

  /// Invokes org.mpris.MediaPlayer2.TrackList.AddTrack()
  Future<void> callAddTrack(String arg_0, DBusObjectPath arg_1, bool arg_2, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.TrackList', 'AddTrack', [DBusString(arg_0), arg_1, DBusBoolean(arg_2)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.TrackList.RemoveTrack()
  Future<void> callRemoveTrack(DBusObjectPath arg_0, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.TrackList', 'RemoveTrack', [arg_0], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.mpris.MediaPlayer2.TrackList.GoTo()
  Future<void> callGoTo(DBusObjectPath arg_0, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.mpris.MediaPlayer2.TrackList', 'GoTo', [arg_0], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}
