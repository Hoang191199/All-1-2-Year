import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/presentation/controllers/search/search_binding.dart';
import 'package:qltv/presentation/pages/search/widgets/detail_item.dart';
import 'package:qltv/presentation/widgets/publication_image.dart';

class HomePublicationItem extends StatelessWidget {
  const HomePublicationItem({super.key, this.publication});

  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
        SearchBinding().dependencies();
        Get.to(() => DetailItem(publicationDetail: publication));
    }, 
    child: SizedBox(
      width: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              PublicationImage(
                widthImage: 100.0,
                heightImage: 144.0,
                imageUrl: publication?.image_url,
                isShowDigital: publication?.has_digital ?? false,
                isShowInfo: false,
              ),
              const SizedBox(height: 4.0),
              Row(
                children: getListStarViewOfFive(5.0),
              ),
              const SizedBox(height: 6.0),
              Text(publication?.title ?? '',
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: HexColor('343232')
                      )
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis
              ),
            ],
          ),
          Row(
            children: [
              Text('${'in-stock'.tr} : ${publication?.still ?? 0}',
                style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                    fontSize: 10.0,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  )
                )
              )
            ],
          )
        ],
      ),
    ));
  }
}
