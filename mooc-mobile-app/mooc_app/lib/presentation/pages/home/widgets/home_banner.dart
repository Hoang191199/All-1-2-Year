import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mooc_app/domain/entities/slide_show.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
    required this.listBannerData,
    required this.altBanner,
  }) : super(key: key);

  final List<SlideShow> listBannerData;
  final List<String> altBanner;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    // var bannerNumber = 2;
    List<Widget> listBanner = [];
    // if (listBannerData.isNotEmpty) {
    //   bannerNumber = listBannerData.length;
    //   for (var i = 0; i < listBannerData.length; i++) {
    //     listBanner.add(CachedNetworkImage(
    //       imageUrl: listBannerData[i].image_url,
    //       width: 400.0,
    //       height: 180.0,
    //       fit: BoxFit.cover,
    //       // placeholder: (context, url) => const CircularProgressIndicator(),
    //       // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
    //       progressIndicatorBuilder: (context, url, downloadProgress) =>
    //           const SizedBox(),
    //       errorWidget: (context, url, error) => const Icon(Icons.error),
    //     )
    //         // Image.network(
    //         //   listBannerData[i].image_url,
    //         //   width: 400.0,
    //         //   height: 180.0,
    //         //   fit: BoxFit.cover,
    //         // ),
    //         );
    //   }
    // } else {
    //   for (var i = 0; i < bannerNumber; i++) {
    //     listBanner.add(
    //       Image.asset(
    //         'assets/images/banner_home_1.png',
    //         width: 400.0,
    //         height: 180.0,
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   }
    // }
    for (var i = 0; i < altBanner.length; i++) {
      listBanner.add(
        Image.asset(
          altBanner[i],
          width: 400.0,
          height: 180.0,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: widthScreen,
      padding: const EdgeInsets.all(10.0),
      child: CarouselSlider.builder(
        itemCount: altBanner.length,
        itemBuilder: (context, index, ind) => listBanner[index],
        options: CarouselOptions(
          pageSnapping: false,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeCenterPage: true,
          autoPlay: true,
          viewportFraction: 0.8,
          height: 180,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
