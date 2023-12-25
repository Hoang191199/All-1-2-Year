import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class SchoolAboutPage extends StatelessWidget {
  SchoolAboutPage({
    super.key,
    required this.pageName,
  });

  final String pageName;

  final showPageController = Get.find<ShowPageController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: showPageController,
      initState: (state) async {
        showPageController.showPageAbout(pageName);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: showPageController.isLoadingAbout.value
            ? const Center(
              child: CircularLoadingIndicator(),
            )
            : Container(
              padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTagTop(tagName: 'Giới thiệu'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: widthScreen,
                            height: context.responsive(220.0),
                            decoration: showPageController.aboutPageData.value?.page_cover?.isNotEmpty ?? false
                              ? BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(showPageController.aboutPageData.value?.page_cover ?? ''),
                                  fit: BoxFit.cover
                                ),
                              )
                              : BoxDecoration(
                                color: HexColor('FFDFF1'),
                              )
                          ),
                          separateContainer(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.responsive(6.0)),
                              titleInfo(context, 'Chi tiết'),
                              SizedBox(height: context.responsive(4.0)),
                              item1(context, 'Loại hình trường: ', getSchoolNameByType()),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Tuổi: ', '${showPageController.aboutPageData.value?.start_age} tháng - ${showPageController.aboutPageData.value?.end_age} tháng'),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Địa chỉ: ', showPageController.aboutPageData.value?.address ?? ''),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Học phí: ', '${formatCurrencyVNFromString(showPageController.aboutPageData.value?.start_tuition_fee)} - ${formatCurrencyVNFromString(showPageController.aboutPageData.value?.end_tuition_fee)}'),
                            ],
                          ),
                          separateContainer(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.responsive(6.0)),
                              titleInfo(context, 'Liên hệ'),
                              SizedBox(height: context.responsive(4.0)),
                              item1(context, 'Email: ', showPageController.aboutPageData.value?.email ?? ''),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Điện thoại: ', showPageController.aboutPageData.value?.telephone ?? ''),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Trang web: ', showPageController.aboutPageData.value?.website ?? ''),
                              const HorizontalDividerNoPadding(),
                              item1(context, 'Facebook', ''),
                            ],
                          ),
                          separateContainer(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.responsive(6.0)),
                              titleInfo(context, 'Dịch vụ'),
                              SizedBox(height: context.responsive(4.0)),
                              if (showPageController.aboutPageData.value?.service_breakfast == '1')
                                Column(
                                  children: [
                                    item2(context, 'Ăn sáng'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.service_saturday == '1')
                                Column(
                                  children: [
                                    item2(context, 'Trông thứ 7'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.service_bus == '1')
                                Column(
                                  children: [
                                    item2(context, 'Xe đưa đón'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.service_belated == '1')
                                item2(context, 'Đón con muộn'),
                            ],
                          ),
                          separateContainer(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.responsive(6.0)),
                              titleInfo(context, 'Cơ sở vật chất'),
                              SizedBox(height: context.responsive(4.0)),
                              if (showPageController.aboutPageData.value?.facility_pool == '1')
                                Column(
                                  children: [
                                    item2(context, 'Bể bơi'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.facility_playground_out == '1')
                                Column(
                                  children: [
                                    item2(context, 'Sân chơi ngoài trời'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.facility_playground_in == '1')
                                Column(
                                  children: [
                                    item2(context, 'Sân chơi trong nhà'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.facility_library == '1')
                                Column(
                                  children: [
                                    item2(context, 'Thư viện'),
                                    const HorizontalDividerNoPadding(),
                                  ],
                                ),
                              if (showPageController.aboutPageData.value?.facility_camera == '1')
                                item2(context, 'Camera'),
                            ],
                          ),
                          if (showPageController.aboutPageData.value?.info_method?.isNotEmpty ?? false)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                separateContainer(context),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: context.responsive(6.0)),
                                    titleInfo(context, 'Chương trình học'),
                                    item3(context, showPageController.aboutPageData.value?.info_method ?? '')
                                  ],
                                )
                              ],
                            ),
                          if (showPageController.aboutPageData.value?.info_leader?.isNotEmpty ?? false)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                separateContainer(context),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: context.responsive(6.0)),
                                    titleInfo(context, 'Đội ngũ lãnh đạo'),
                                    item3(context, showPageController.aboutPageData.value?.info_leader ?? '')
                                  ],
                                )
                              ],
                            ),
                          separateContainer(context),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
        );
      }
    );
  }

  String getSchoolNameByType() {
    switch (showPageController.aboutPageData.value?.type) {
      case '1':
        return 'Trường tư thục';
      case '2':
        return 'Trường bán công';
      case '3':
        return 'Trường công lập';
      case '4':
        return 'Trường quốc tế';
      case '51':
        return 'Trường song ngữ';
      default:
        return '';
    }
  }

  String formatCurrencyVNFromString(String? moneyStr) {
    return NumberFormat("#,##0", "vi_VN").format(double.parse(moneyStr ?? '0'));
  }

  Widget separateContainer(BuildContext context) {
    return Container(
      height: context.responsive(10.0),
      decoration: BoxDecoration(
        color: HexColor('D8D8D8')
      ),
    );
  }

  Widget titleInfo(BuildContext context, String titleText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
      child: Text(
        titleText,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
        ),
      ),
    );
  }

  Widget item1(BuildContext context, String text1, String text2) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsive(10.0), horizontal: context.responsive(28.0)),
      child: RichText(
        text: TextSpan(
          text: text1,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
          ),
          children: [
            TextSpan(
              text: text2,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('783199'))
              ),
            )
          ]
        )
      ),
    );
  }

  Widget item2(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsive(10.0), horizontal: context.responsive(28.0)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/bookmark-double.png',
            width: context.responsive(16.0),
            height: context.responsive(16.0),
            fit: BoxFit.cover,
          ),
          SizedBox(width: context.responsive(8.0)),
          Text(
            text,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
            ),
          )
        ],
      ),
    );
  }

  Widget item3(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsive(14.0), horizontal: context.responsive(28.0)),
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
            ),
          )
        ],
      ),
    );
  }
}