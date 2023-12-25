import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_grid_view_item.dart';

class BookcaseGridView extends StatelessWidget {
  BookcaseGridView({super.key});

  final bookcaseController = Get.find<BookcaseController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;

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
        return GridView.count(
          controller: scrollController,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
          shrinkWrap: true,
          childAspectRatio: 100 / 215,
          // childAspectRatio: (widthScreen - 28.0 - 28.0) / getHeightGridView(),
          // physics: const ClampingScrollPhysics(),
          children: List.generate(
            bookcaseController.bookcasesData.length, 
            (index) => BookcaseGridViewItem(
              bookcase: bookcaseController.bookcasesData[index],
                )
            ),
        );
      }
    );
  }

  double getHeightGridView() {
    const heightItem = 215.0;
    final surplus = bookcaseController.bookcasesData.length % 3;
    final rowNumber = surplus > 0 ? (bookcaseController.bookcasesData.length / 3).floor() + 1 : bookcaseController.bookcasesData.length / 3;
    return heightItem * rowNumber + 20.0 * (rowNumber - 1) + 10.0 * 2;
  }

  Future<void> scrollListener() async {
    if (scrollController.position.extentAfter < 500) {
      await bookcaseController.loadMore();
    }
  }
}