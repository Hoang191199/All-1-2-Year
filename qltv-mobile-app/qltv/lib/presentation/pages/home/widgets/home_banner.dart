import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/metadata_item.dart';
import 'package:qltv/presentation/controllers/carousel_controller.dart';

class HomeBanner extends StatelessWidget {
  HomeBanner({
    super.key,
    required this.carouselController,
    required this.listBannerData,
  });

  final CarouselController carouselController;
  final List<MetadataItem> listBannerData;
  final cr = Get.put(CarouselSlideController());
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    List<Widget> listBanner = [];
    if (listBannerData.isNotEmpty) {
      for (var i = 0; i < listBannerData.length; i++) {
        if (listBannerData[i].image_url?.isNotEmpty ?? false) {
          listBanner.add(ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: listBannerData[i].image_url ?? '',
              width: widthScreen,
              height: 184.0,
              fit: BoxFit.cover,
              // placeholder: (context, url) => const CircularProgressIndicator(),
              // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const SizedBox(),
              errorWidget: (context, url, error) =>
                  const Icon(CupertinoIcons.info),
            ),
          ));
        }
      }
    }
    List<int> items = List.generate(listBanner.length, (i) => i);
    return listBanner.isNotEmpty
        ? Obx(() => Column(children: [
              CarouselSlider.builder(
                itemCount: listBanner.length,
                itemBuilder: (context, index, ind) => listBanner[index],
                carouselController: carouselController,
                options: CarouselOptions(
                    pageSnapping: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    // enlargeCenterPage: true,
                    autoPlay: true,
                    // viewportFraction: 0.8,
                    viewportFraction: 1.0,
                    height: 184,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    onPageChanged: (index, reason) {
                      cr.current.value = index;
                    },
                    scrollPhysics: const PageScrollPhysics(),
                    pauseAutoPlayOnManualNavigate: true,
                    pauseAutoPlayOnTouch: true),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i in items)
                  GestureDetector(
                    onTap: () {
                      // current.value = i;
                      carouselController.animateToPage(i);
                    },
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      decoration: cr.current.value == i
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue[900]))
                          : const ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 2, color: Colors.grey))),
                    ),
                  )
              ]),
            ]))
        : Container();
  }
}
