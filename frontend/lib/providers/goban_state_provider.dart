import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/joseki.dart';

class GobanStateNotifier extends StateNotifier<GobanState> {
  GobanStateNotifier() : super(GobanState(Joseki([])));

  void updateGoban(Joseki joseki) {
    state = GobanState(joseki);
  }

  void resetGoban() {
    state = GobanState(Joseki([]));
  }
}

final gobanStateNotifierProvider =
    StateNotifierProvider<GobanStateNotifier, GobanState>(
      (ref) => GobanStateNotifier(),
    );
