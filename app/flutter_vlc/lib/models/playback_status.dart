enum PlaybackStatus {
  stopped('Stopped'),
  paused('Paused'),
  playing('Playing');

  final String string;
  const PlaybackStatus(this.string);
  factory PlaybackStatus.from(String string) =>
      PlaybackStatus.values.firstWhere((v) => v.string == string);
}
