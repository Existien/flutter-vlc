class Metadata {
  final String? album;
  final String? trackid;
  final String? url;
  final String? title;
  final List<String> genre;
  final List<String> artist;
  final String? artUrl;
  Metadata({
    this.album,
    this.trackid,
    this.url,
    this.title,
    this.genre = const [],
    this.artist = const [],
    this.artUrl,
  });
}
