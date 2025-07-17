import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/goban/goban.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/providers/provider.dart';

class Pagination extends ConsumerStatefulWidget {
  const Pagination({super.key});
  @override
  ConsumerState<Pagination> createState() => _PaginationState();
}

class _PaginationState extends ConsumerState<Pagination> {
  Joseki newJoseki = Joseki([]);
  int currentPage = 0;
  int totalPage = 0;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    Joseki joseki = ref.watch(josekiStateNotifierProvider);
    // if (widget.josekiList.isEmpty) {
    //   return Center(child: Text('手順が登録されていません'));
    // } else {
    //   return Goban(joseki: widget.josekiList[currentPage]);
    // }
    return Column(
      children: [
        Goban(joseki: joseki),
        Button(
          text: "push",
          onPressed: () {
            ref
                .read(josekiStateNotifierProvider.notifier)
                .updateMessage(Joseki([]));
          },
        ),
      ],
    );
  }
}
