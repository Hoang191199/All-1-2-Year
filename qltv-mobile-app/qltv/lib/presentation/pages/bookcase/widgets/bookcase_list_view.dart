import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_list_view_item.dart';

class BookcaseListView extends StatelessWidget {
  BookcaseListView({super.key});

  final bookcaseController = Get.find<BookcaseController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: bookcaseController,
      initState: (state) {
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return ListView.separated(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
          shrinkWrap: true,
          itemCount: bookcaseController.bookcasesData.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0), 
          itemBuilder: (context, index) => BookcaseListViewItem(
            type: 'list_view',
            bookcase: bookcaseController.bookcasesData[index],
          ), 
        );
      }
    );
  }

  Future<void> scrollListener() async {
    if (scrollController.position.extentAfter < 500) {
      await bookcaseController.loadMore();
    }
  }
}