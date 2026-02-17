enum LoopStatus {
  none('None'),
  track('Track'),
  playList('Playlist');

  final String string;
  const LoopStatus(this.string);
  factory LoopStatus.from(String string) =>
      LoopStatus.values.firstWhere((v) => v.string == string);
}
