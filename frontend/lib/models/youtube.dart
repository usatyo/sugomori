class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> data) {
    return Video(
      id: data['id'],
      title: data['snippet']['title'],
      thumbnailUrl: data['snippet']['thumbnails']['medium']['url'],
      channelTitle: data['snippet']['channelTitle'],
    );
  }
}
