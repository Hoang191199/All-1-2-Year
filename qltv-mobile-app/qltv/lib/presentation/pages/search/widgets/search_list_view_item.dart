import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/detail_item.dart';
import 'package:qltv/presentation/pages/search/widgets/search_image.dart';

class SearchListViewItem extends StatelessWidget {
  SearchListViewItem({super.key, this.item});

  final Search? item;
  final searchController = Get.find<search.SearchController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Get.to(() => DetailItem(itemDetail: item));
          searchController.seen(item?.id ?? 0);
        },
        child: Row(
          children: [
            SearchImage(
              widthImage: 100.0,
              heightImage: 144.0,
              imageUrl: item?.image_url ?? item?.image,
              isShowDigital: item?.object_type == "publications" ? false : true,
              isShowInfo: true,
              search: item,
            ),
            const SizedBox(height: 6.0),
            Expanded(
                child: Container(
                    width: widthScreen,
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item?.title ?? "",
                            style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(
                                    fontSize: 22.0,
                                    height: 1.4,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor('333333'))),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        Text(
                          '${item?.authors}'
                          '${item?.publication_year == null ? '' : '(${item?.publication_year})'}',
                          style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor('333333'))),
                        ),
                        Text(
                          '${'status'.tr}: ${item?.remain != null ? 'ready-lend'.tr : 'out-of-book'.tr}',
                          style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor('333333'))),
                        ),
                        item?.object_type == "publications"
                            ? Text(
                                '${'remain'.tr}: ${item?.remain ?? 0}',
                                style: GoogleFonts.kantumruy(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor('333333'))),
                              )
                            : const SizedBox()
                      ],
                    )))
          ],
        ));
  }
}
