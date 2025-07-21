import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/goban/goban.dart';
import 'package:frontend/l10n/app_localizations.dart';
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
  int currentPage = 0;
  int totalPage = 0;
  bool isEditing = false;
  bool isAddLoading = false;
  bool isDeleteLoading = false;
  List<Joseki> josekiList = [];
  List<Joseki> newJosekiList = [];
  final JosekiApiService josekiApiService = JosekiApiService.instance;

  @override
  void initState() {
    super.initState();
    Future(() async {
      newJosekiList = await josekiApiService.getJoseki(widget.videoId);
      setState(() {
        totalPage = newJosekiList.length;
        josekiList = newJosekiList;
        refreshGoban();
      });
    });
  }

  void refreshGoban() {
    if (josekiList.length <= currentPage) {
      ref.read(gobanStateNotifierProvider.notifier).resetGoban();
    } else {
      ref
          .read(gobanStateNotifierProvider.notifier)
          .updateGoban(josekiList[currentPage]);
    }
  }

  void deleteJoseki() async {
    if (isEditing) {
      setState(() {
        isEditing = false;
        totalPage--;
        if (currentPage >= totalPage) {
          currentPage = max(totalPage - 1, 0);
        }
      });
      refreshGoban();
    } else {
      if (josekiList.isEmpty) return;
      setState(() {
        isDeleteLoading = true;
      });
      await josekiApiService.deleteJoseki(
        widget.videoId,
        josekiList[currentPage],
      );
      setState(() {
        josekiList.removeAt(currentPage);
        totalPage = josekiList.length;
        if (currentPage >= totalPage) {
          currentPage = max(totalPage - 1, 0);
        }
        isDeleteLoading = false;
      });
      if (totalPage != 0) {
        refreshGoban();
      }
    }
  }

  void addJoseki() async {
    if (isEditing) {
      setState(() {
        isAddLoading = true;
      });
      Joseki newJoseki = ref.read(gobanStateNotifierProvider).joseki;
      await josekiApiService.postJoseki(newJoseki, widget.videoId);
      setState(() {
        isEditing = false;
        josekiList.add(newJoseki);
        isAddLoading = false;
      });
      refreshGoban();
    } else {
      setState(() {
        isEditing = true;
        totalPage++;
        currentPage = totalPage - 1;
      });
      ref.read(gobanStateNotifierProvider.notifier).resetGoban();
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
                        if (totalPage == 0) return;
                        if (isEditing) return;
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
                        if (totalPage == 0) return;
                        if (isEditing) return;
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
              text: AppLocalizations.of(context)!.button_delete,
              onPressed: isDeleteLoading ? null : deleteJoseki,
              color: Colors.red,
              fit: true,
            ),
            Button(
              text:
                  isEditing
                      ? AppLocalizations.of(context)!.button_add
                      : AppLocalizations.of(context)!.button_new,
              onPressed: isAddLoading ? null : addJoseki,
              fit: true,
            ),
          ],
        ),
        totalPage == 0
            ? Text(AppLocalizations.of(context)!.message_joseki_not_found)
            : Goban(isEditable: isEditing),
      ],
    );
  }
}
