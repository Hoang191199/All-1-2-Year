import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search_controller;
import 'package:qltv/presentation/pages/search/widgets/detail_item.dart';

class SearchImage extends StatelessWidget {
  SearchImage({
    super.key,
    required this.widthImage,
    required this.heightImage,
    this.imageUrl,
    required this.isShowDigital,
    required this.isShowInfo,
    this.search,
  });

  final double widthImage;
  final double heightImage;
  final String? imageUrl;
  final bool isShowDigital;
  final bool isShowInfo;
  final Search? search;
  final searchController = Get.find<search_controller.SearchController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: !isShowInfo
              ? null
              : () {
                  Get.to(() => DetailItem(itemDetail: search));
                  searchController.seen(search?.id ?? 0);
                },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: imageUrl == null || (imageUrl?.isEmpty ?? false)
                ? Image.asset(
                    'assets/images/no_image_publication.png',
                    width: widthImage,
                    height: heightImage,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl ?? '',
                    width: widthImage,
                    height: heightImage,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const SizedBox(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no_image_publication.png',
                      width: widthImage,
                      height: heightImage,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        isShowDigital
            ? Positioned(
                bottom: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: HexColor('FFFDFD'),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.0))),
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.headphones,
                          size: 10.0, color: Colors.black),
                      SizedBox(width: 3.0),
                      Text('/',
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black)),
                      SizedBox(width: 3.0),
                      Icon(CupertinoIcons.book, size: 10.0, color: Colors.black)
                    ],
                  ),
                ))
            : Container()
      ],
    );
  }
}
