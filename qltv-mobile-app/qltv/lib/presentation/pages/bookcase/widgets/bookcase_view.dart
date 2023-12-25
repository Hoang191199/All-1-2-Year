import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_grid_view.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_list_view.dart';

class BookcaseView extends StatelessWidget {
  BookcaseView({super.key});

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => bookcaseController.bookcaseViewType.value == BookcaseViewType.grid
        ? BookcaseGridView()
        : BookcaseListView()
    );
  }
}