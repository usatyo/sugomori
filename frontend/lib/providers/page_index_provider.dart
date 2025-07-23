import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndexNotifier extends StateNotifier<int> {
  PageIndexNotifier() : super(0);

  void update(int index) {
    state = index;
  }
}

final pageIndexNotifierProvider = StateNotifierProvider<PageIndexNotifier, int>(
  (ref) => PageIndexNotifier(),
);
