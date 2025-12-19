import 'package:frontend/models/joseki.dart';

class JosekiVideoRequest {
  final List<Stone> stones;
  final String videoId;

  JosekiVideoRequest({
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

class StonesRequest {
  final List<Stone> stones;

  StonesRequest({
    required this.stones,
  });

  Map<String, dynamic> toJson() => {
    'stones': stones.map((stone) => stone.toJson()).toList(),
  };
}