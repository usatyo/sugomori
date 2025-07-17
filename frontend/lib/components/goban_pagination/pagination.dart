import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/goban/goban.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/providers/provider.dart';
import 'package:frontend/services/joseki_api_service.dart';

class Pagination extends ConsumerStatefulWidget {
  const Pagination({super.key, required this.videoId});
  final String videoId;

  @override
  ConsumerState<Pagination> createState() => _PaginationState();
}

class _PaginationState extends ConsumerState<Pagination> {
  Joseki newJoseki = Joseki([]);
  int currentPage = 0;
  int totalPage = 0;
  bool isEditing = false;
  List<Joseki> josekiList = [];
  List<Joseki> newJosekiList = [];
  final JosekiApiService josekiApiService = JosekiApiService.instance;

  @override
  void initState() {
    super.initState();
    Future(() async {
      newJosekiList = await josekiApiService.getJoseki(widget.videoId);
      if (newJosekiList.isNotEmpty) {
        refreshGoban();
      }
      setState(() {
        totalPage = newJosekiList.length;
        josekiList = newJosekiList;
      });
    });
  }

  void refreshGoban() {
    ref
        .read(gobanStateNotifierProvider.notifier)
        .updateGoban(newJosekiList[currentPage]);
  }

  void deleteJoseki() async {
    if (josekiList.isEmpty) return;
    josekiApiService.deleteJoseki(widget.videoId, josekiList[currentPage]);
    setState(() {
      josekiList.removeAt(currentPage);
      totalPage = josekiList.length;
      if (currentPage >= totalPage) {
        currentPage = max(totalPage - 1, 0);
      }
    });
    if (totalPage != 0) {
      refreshGoban();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
          children: [
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentPage = (currentPage - 1) % totalPage;
                          refreshGoban();
                        });
                      },
                      icon: Icon(Icons.arrow_left, size: 40),
                    ),
                    Text(
                      '${currentPage + 1} / $totalPage',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentPage = (currentPage + 1) % totalPage;
                          refreshGoban();
                        });
                      },
                      icon: Icon(Icons.arrow_right, size: 40),
                    ),
                  ],
                ),
              ),
            ),
            Button(
              text: '削除',
              onPressed: deleteJoseki,
              color: Colors.red,
              fit: true,
            ),
            Button(text: '新規', onPressed: () {}, fit: true),
          ],
        ),
        totalPage == 0 ? Goban() : Goban(isEditable: false,),
      ],
    );
  }
}
