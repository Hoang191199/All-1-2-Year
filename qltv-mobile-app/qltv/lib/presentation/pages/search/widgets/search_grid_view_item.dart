import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/detail_item.dart';
import 'package:qltv/presentation/pages/search/widgets/search_image.dart';

class SearchGridViewItem extends StatelessWidget {
  SearchGridViewItem({super.key, this.item});

  final Search? item;
  final searchController = Get.find<search.SearchController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => DetailItem(itemDetail: item));
          searchController.seen(item?.id ?? 0);
        },
        child: SizedBox(
            width: 110.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchImage(
                      widthImage: 110.0,
                      heightImage: 144.0,
                      imageUrl: item?.image_url ?? item?.image,
                      isShowDigital:
                          item?.object_type == "publications" ? false : true,
                      isShowInfo: true,
                      search: item,
                    ),
                    const SizedBox(height: 6.0),
                    Text(item?.title ?? "",
                        style: GoogleFonts.kantumruy(
                            textStyle: TextStyle(
                                fontSize: 14.0,
                                height: 1.4,
                                fontWeight: FontWeight.w700,
                                color: HexColor('343232'))),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                item?.object_type == "publications"
                    ? Row(
                        children: [
                          Text('${'remain'.tr}: ${item?.remain ?? 0}',
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 10.0,
                                      height: 1.7,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)))
                        ],
                      )
                    : const SizedBox()
              ],
            )));
  }
}
