import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/joseki.dart';

class JosekiStateNotifier extends StateNotifier<Joseki> {
  JosekiStateNotifier() : super(Joseki([]));

  void updateMessage(Joseki joseki) {
    state = Joseki([
      Stone(StoneColor.black, 2, 2, 0),
      Stone(StoneColor.white, 3, 2, 0),
      Stone(StoneColor.black, 4, 2, 0),
    ]);
  }
}

final josekiStateNotifierProvider =
    StateNotifierProvider<JosekiStateNotifier, Joseki>(
      (ref) => JosekiStateNotifier(),
    );
