import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/view_image_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';

class GridViewPhoto extends StatelessWidget {
  const GridViewPhoto({
    super.key,
    required this.controller,
    required this.listPhoto,
    required this.sizeWidth,
    required this.sizeHeight,
  });

  final ScrollController controller;
  final List<PhotoPost> listPhoto;
  final double sizeWidth;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: controller,
      // physics: const ClampingScrollPhysics(),
      crossAxisCount: context.responsive(3),
      mainAxisSpacing: context.responsive(2.0),
      crossAxisSpacing: context.responsive(2.0),
      padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
      shrinkWrap: true,
      children: List.generate(
        listPhoto.length, 
        (index) => GestureDetector(
          onTap: () {
            handlePressImage(listPhoto, index);
          },
          child: ItemImageRect(
            imageUrl: listPhoto[index].source ?? '', 
            width: sizeWidth,
            height: sizeHeight,
            borderRadius: 0,
          ),
        )
      ),
    );
  }
  
  void handlePressImage(List<PhotoPost> listPhoto, int index) {
    List<String> sourceArr = [];
    for (var element in listPhoto) {
      sourceArr.add(element.source ?? '');
    }
    Get.to(
      () => ViewImagePage(
        imageNetworkUrlArr: sourceArr,
        selectIndexPage: index,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}