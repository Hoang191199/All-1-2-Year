import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/pages/search/widgets/list_tags.dart';

class InfoArchivesWidget extends StatelessWidget {
  const InfoArchivesWidget({
    super.key,
    this.itemDetail,
  });

  final Search? itemDetail;

  @override
  Widget build(BuildContext context) {
    List<String> tag = itemDetail?.tag?.split(",") ?? [];

    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text('present'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                        color: HexColor('333333')),
                  ))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Html(
                data: itemDetail?.info ?? 'data-update'.tr,
                style: {
                  '*': Style(
                      lineHeight: const LineHeight(1.4),
                      fontSize: FontSize(14.0),
                      color: HexColor('333333'),
                      fontFamily: 'Kantumruy'),
                },
              )),
          const SizedBox(height: 22),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text('topic-document'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: HexColor('333333')),
                  ))),
          const SizedBox(height: 4),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(itemDetail?.subject ?? 'data-update'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: HexColor('004390')),
                  ))),
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text('format'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: HexColor('333333')),
                  ))),
          const SizedBox(height: 4),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(itemDetail?.format ?? 'data-update'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: HexColor('004390')),
                  ))),
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text('type-document'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: HexColor('333333')),
                  ))),
          const SizedBox(height: 4),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(itemDetail?.model ?? 'data-update'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: HexColor('004390')),
                  ))),
          const SizedBox(height: 8),
          tag != []
              ? SizedBox(
                  height: 30.0,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 4.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: tag.length,
                        itemBuilder: (context, index) => ListTags(
                              index: index,
                              name: tag[index],
                            )),
                  ))
              : const SizedBox()
        ]),
      ),
    );
  }
}
