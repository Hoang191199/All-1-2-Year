import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/view_image_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';

class NewsFeedSectionItemImage extends StatelessWidget {
  const NewsFeedSectionItemImage({
    super.key,
    this.postNews,
  });

  final PostNews? postNews;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final widthScreenSubPadding = widthScreen - context.responsive(40.0);

    return Column(
      children: [
        if ((postNews?.photos_num ?? 0) == 1)
          GestureDetector(
            onTap: () {
              handlePressImage(postNews?.photos, 0);
            },
            child: ItemImageRect(
              imageUrl: postNews?.photos?[0].source ?? '', 
              width: widthScreenSubPadding, 
            ),
          ),
        if ((postNews?.photos_num ?? 0) == 2)
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  handlePressImage(postNews?.photos, 0);
                },
                child: ItemImageRect(
                  imageUrl: postNews?.photos?[0].source ?? '', 
                  width: (widthScreenSubPadding - context.responsive(8.0)) / 2, 
                  height: (widthScreenSubPadding - context.responsive(8.0)) / 2
                ),
              ),
              SizedBox(width: context.responsive(8.0)),
              GestureDetector(
                onTap: () {
                  handlePressImage(postNews?.photos, 1);
                },
                child: ItemImageRect(
                  imageUrl: postNews?.photos?[1].source ?? '', 
                  width: (widthScreenSubPadding - context.responsive(8.0)) / 2, 
                  height: (widthScreenSubPadding - context.responsive(8.0)) / 2
                ),
              ),
            ],
          ),
        if ((postNews?.photos_num ?? 0) >= 3)
          GestureDetector(
            onTap: () {
              handlePressImage(postNews?.photos, 0);
            },
            child: ItemImageRect(
              imageUrl: postNews?.photos?[0].source ?? '', 
              width: widthScreenSubPadding, 
              height: widthScreenSubPadding / 2
            ),
          ),
        if ((postNews?.photos_num ?? 0) == 3)
          Column(
            children: [
              SizedBox(height: context.responsive(8.0)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      handlePressImage(postNews?.photos, 1);
                    },
                    child: ItemImageRect(
                      imageUrl: postNews?.photos?[1].source ?? '', 
                      width: (widthScreenSubPadding - context.responsive(8.0)) / 2, 
                      height: (widthScreenSubPadding - context.responsive(8.0)) / 2
                    ),
                  ),
                  SizedBox(width: context.responsive(8.0)),
                  GestureDetector(
                    onTap: () {
                      handlePressImage(postNews?.photos, 2);
                    },
                    child: ItemImageRect(
                      imageUrl: postNews?.photos?[2].source ?? '', 
                      width: (widthScreenSubPadding - context.responsive(8.0)) / 2, 
                      height: (widthScreenSubPadding - context.responsive(8.0)) / 2
                    ),
                  ),
                ],
              )
            ],
          ),
        if ((postNews?.photos_num ?? 0) >= 4)
          Column(
            children: [
              SizedBox(height: context.responsive(8.0)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      handlePressImage(postNews?.photos, 1);
                    },
                    child: ItemImageRect(
                      imageUrl: postNews?.photos?[1].source ?? '', 
                      width: (widthScreenSubPadding - context.responsive(16.0)) / 3, 
                      height: (widthScreenSubPadding - context.responsive(16.0)) / 3
                    ),
                  ),
                  SizedBox(width: context.responsive(8.0)),
                  GestureDetector(
                    onTap: () {
                      handlePressImage(postNews?.photos, 2);
                    },
                    child: ItemImageRect(
                      imageUrl: postNews?.photos?[2].source ?? '', 
                      width: (widthScreenSubPadding - context.responsive(16.0)) / 3, 
                      height: (widthScreenSubPadding - context.responsive(16.0)) / 3
                    ),
                  ),
                  SizedBox(width: context.responsive(8.0)),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handlePressImage(postNews?.photos, 3);
                        },
                        child: ItemImageRect(
                          imageUrl: postNews?.photos?[3].source ?? '', 
                          width: (widthScreenSubPadding - context.responsive(16.0)) / 3, 
                          height: (widthScreenSubPadding - context.responsive(16.0)) / 3
                        ),
                      ),
                      if ((postNews?.photos_num ?? 0) > 4)
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0))),
                          child: Container(
                            width: (widthScreenSubPadding - context.responsive(16.0)) / 3,
                            height: (widthScreenSubPadding - context.responsive(16.0)) / 3,
                            decoration: const BoxDecoration(
                              color: Color(0x33333333)
                            ),
                            child: Center(
                              child: SizedBox(
                                height: context.responsive(28.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: context.responsive(24.0),
                                      child: Text(
                                        '+',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(fontSize: context.responsive(28.0), fontWeight: FontWeight.w500, color: HexColor('FFFFFF')),
                                        )
                                      ),
                                    ),
                                    Text(
                                      '${(postNews?.photos_num ?? 0) - 4}',
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: context.responsive(20.0), 
                                          height: context.responsive(1.4), 
                                          fontWeight: FontWeight.w700, 
                                          color: HexColor('FFFFFF')
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              )
            ],
          )
      ],
    );
  }

  void handlePressImage(List<PhotoPost>? photos, int index) {
    List<String> sourceArr = [];
    for (var element in photos ?? []) {
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