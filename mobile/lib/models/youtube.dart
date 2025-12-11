class PartVideo {
  final String id;
  final String title;
  final String thumbnailUrl;

  PartVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory PartVideo.fromMap(Map<String, dynamic> videoData) {
    return PartVideo(
      id: videoData['id'],
      title: videoData['snippet']['localized']['title'],
      thumbnailUrl: videoData['snippet']['thumbnails']['medium']['url'],
    );
  }

  String format() {
    return 'id: $id, title: $title, thumbnailUrl: $thumbnailUrl';
  }
}

class Channel {
  final String id;
  final String title;
  final String thumbnailUrl;

  Channel({required this.id, required this.title, required this.thumbnailUrl});

  factory Channel.fromMap(Map<String, dynamic> data) {
    return Channel(
      id: data['id'],
      title: data['snippet']['title'],
      thumbnailUrl: data['snippet']['thumbnails']['default']['url'],
    );
  }

  String format() {
    return 'id: $id, title: $title, thumbnailUrl: $thumbnailUrl';
  }
}

class Video extends PartVideo {
  final Channel channel;

  Video({
    required this.channel,
    required super.id,
    required super.title,
    required super.thumbnailUrl,
  });

  factory Video.fromMap(PartVideo partvVideos, Channel channel) {
    return Video(
      channel: channel,
      id: partvVideos.id,
      title: partvVideos.title,
      thumbnailUrl: partvVideos.thumbnailUrl,
    );
  }
}
