import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';

class SchoolPageRate extends StatelessWidget {
  SchoolPageRate({super.key});

  final showPageController = Get.find<ShowPageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            handlePressRate(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                showPageController.infoPageData.value?.average_review ?? '0.0',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: context.responsive(30.0), 
                    height: context.responsive(0.1), 
                    fontWeight: FontWeight.w700, 
                    color: HexColor('464646')
                  )
                ),
              ),
              SizedBox(width: context.responsive(5.0)),
              Row(
                children: getListStarViewOfFive(
                  double.parse(showPageController.infoPageData.value?.average_review ?? '0.0'), 
                  ((showPageController.infoPageData.value?.average_review?.isNotEmpty ?? false) && !['0.0', '0'].contains(showPageController.infoPageData.value?.average_review))
                    ? HexColor('F1B821')
                    : HexColor('6F6F6F'), 
                  context.responsive(20.0)
                ),
              )
            ],
          ),
        ),
        SizedBox(height: context.responsive(10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              showPageController.infoPageData.value?.total_review ?? '0',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  fontSize: context.responsive(22.0), 
                  height: context.responsive(0.1), 
                  fontWeight: FontWeight.w700, 
                  color: HexColor('6F6F6F')
                )
              ),
            ),
            SizedBox(width: context.responsive(5.0)),
            Icon(CupertinoIcons.person, size: context.responsive(14.0), color: HexColor('6F6F6F'))
          ],
        )
      ],
    );
  }
  
  void handlePressRate(BuildContext context) {
    if (showPageController.infoPageData.value?.allow_review ?? false) {
      showPageController.textRateController.text = '';
      showDialog(
        context: context, 
        builder: (context) {
          return Dialog(
            backgroundColor: HexColor('FFFFFF'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: context.responsive(12.0), horizontal: context.responsive(10.0)),
              width: context.responsive(320.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Đánh giá trang này',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('333333'))
                    ),
                  ),
                  SizedBox(height: context.responsive(4.0)),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: context.responsive(4.0)),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: HexColor('F1B821'),
                    ),
                    glowColor: HexColor('FFFFFF'),
                    onRatingUpdate: (rating) {
                      showPageController.rateNumber.value = rating;
                    },
                  ),
                  SizedBox(height: context.responsive(16.0)),
                  TextField(
                    controller: showPageController.textRateController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Viết đánh giá',
                      hintStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: context.responsive(14.0), 
                          height: context.responsive(1.5), 
                          fontWeight: FontWeight.w500, 
                          color: HexColor('D8D8D8')
                        )
                      ),
                      filled: true,
                      fillColor: HexColor('FFFFFF'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('D9D9D9')),
                        borderRadius: BorderRadius.all(Radius.circular(context.responsive(8.0))),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('D9D9D9')),
                        borderRadius: BorderRadius.all(Radius.circular(context.responsive(8.0))),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: context.responsive(5.0), horizontal: context.responsive(12.0)),
                    ),
                    cursorColor: HexColor('464646'),
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: context.responsive(14.0), 
                        height: context.responsive(1.5), 
                        fontWeight: FontWeight.w500, 
                        color: HexColor('464646'), 
                        decorationThickness: 0.0
                      )
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    minLines: context.responsive(5),
                    maxLines: context.responsive(5),
                  ),
                  SizedBox(height: context.responsive(16.0)),
                  SizedBox(
                    width: context.responsive(300.0),
                    height: context.responsive(40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        handlePressSendRate();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0)))
                        ),
                        elevation: 0.0,
                        backgroundColor: HexColor('FF9ACE'),
                        textStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                        )
                      ),
                      child: const Text('Gửi')
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      showSnackbar(SnackbarType.error, 'Thông báo', 'Bạn không được đánh giá trang này!');
    }
  }
  
  Future<void> handlePressSendRate() async {
    await showPageController.createReviewPage();
  }
}