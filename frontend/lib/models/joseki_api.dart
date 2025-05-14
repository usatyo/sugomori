import 'package:frontend/models/joseki.dart';

class JosekiRequest {
  final List<Stone> stones;
  final String videoId;

  JosekiRequest({
    required this.stones,
    required this.videoId,
  });

  Map<String, dynamic> toJson() => {
    'joseki': {
      'stones': stones.map((stone) => stone.toJson()).toList(),
    },
    'video': {
      'id': videoId,
    },
  };
}