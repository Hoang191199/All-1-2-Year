import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/metadata_model.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/pages/home/widgets/home_focus_label_item.dart';
import 'package:qltv/presentation/pages/home/widgets/home_publication_item.dart';

// ignore: must_be_immutable
class HomeFocus extends StatelessWidget {
  HomeFocus({
    super.key,
    required this.listModelFocus,
  });

  final List<MetadataModel> listModelFocus;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return listModelFocus.isNotEmpty
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(width: 4.0),
                scrollDirection: Axis.horizontal,
                itemCount: listModelFocus.length,
                itemBuilder: (context, index) => HomeFocusLabelItem(
                      index: index,
                      name: listModelFocus.length == labelItem.length
                          ? labelItem[index]
                          : listModelFocus[index].name ?? '',
                    )),
          ),
          const SizedBox(height: 24.0),
          Obx(() => Text(
              listModelFocus.length == labelItem.length
                  ? labelItem[homeController.indexModelFocus.value]
                  : listModelFocus[homeController.indexModelFocus.value].name ??
                      '',
              style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)))),
          const SizedBox(height: 16.0),
          Obx(() => listModelFocus[homeController.indexModelFocus.value]
                      .publication
                      ?.isNotEmpty ??
                  false
              ? SizedBox(
                  height: (144.0 + 4.0 + 14.0 + 6.0 + 40.0 + 15.0 + 17.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          listModelFocus[homeController.indexModelFocus.value]
                                  .publication
                                  ?.length ??
                              0,
                      itemBuilder: (context, index) => HomePublicationItem(
                          publication:
                              listModelFocus[homeController.indexModelFocus.value]
                                  .publication?[index])),
                )
              : Text('no-data'.tr,
                  style: GoogleFonts.kantumruy(
                      textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor('7B858B')))))
        ],
      )
      : Container();
  }

  List<String> labelItem = [
    'learning-book'.tr,
    'manual-book'.tr,
    'ethics-book'.tr,
    'search-book'.tr,
    'other-publications'.tr,
    'lesson-plan'.tr,
    'essay'.tr,
    'work-book'.tr,
  ];
}
