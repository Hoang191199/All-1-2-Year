import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/pages/search/widgets/list_tags.dart';

class InfoBookcaseWidget extends StatelessWidget {
  const InfoBookcaseWidget({
    super.key,
    this.itemDetail,
    this.publicationDetail
  });

  final Search? itemDetail;
  final Publication? publicationDetail;

  @override
  Widget build(BuildContext context) {
    List<String> tag = itemDetail?.tag?.split(",") ?? [];
    List<String> tags = publicationDetail?.metadata?.keywords?.split(",") ?? [];

    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Align(
            alignment: Alignment.bottomLeft,
              child: Text('intro'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    color: HexColor('333333')
                  ), 
                )                             
              )
            ),
            Align(
            alignment: Alignment.bottomLeft,
              child: Html(
                data: itemDetail != null 
                ? (itemDetail?.intro_pub == "" ? 'data-update'.tr : itemDetail?.intro_pub) 
                : (publicationDetail?.metadata?.intro_pub == "" ? 'data-update'.tr : publicationDetail?.metadata?.intro_pub),
                style: {
                  '*': Style(
                    lineHeight: const LineHeight(1.4),
                    fontSize: FontSize(14.0),
                    color: HexColor('333333'),
                    fontFamily: 'Kantumruy'
                  ),
                },
              )
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('publishing-company'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                    color: HexColor('333333')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                itemDetail != null 
                ? ('${itemDetail?.publisher ?? ''} ${checkComma(itemDetail?.publisher, itemDetail?.publication_year)} ${itemDetail?.publication_year ?? ''}')
                : ('${publicationDetail?.publisher ?? ''} ${checkComma(publicationDetail?.publisher, publicationDetail?.publication_year)} ${publicationDetail?.publication_year ?? ''}'),
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                  color: HexColor('004390')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('size'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: HexColor('333333')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text( 
                itemDetail != null 
                ? (itemDetail?.dimension ?? 'data-update'.tr)
                : (publicationDetail?.metadata?.dimension ?? 'data-update'.tr),
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                  color: HexColor('004390')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('cover-type'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: HexColor('333333')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                 itemDetail != null 
                ? (coverType(itemDetail?.cover_type ?? '1'))
                : (coverType(publicationDetail?.metadata?.cover_type ?? '1')),
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                  color: HexColor('004390')
                  ), 
                )         
              )
            ),
            const SizedBox(height: 8),
            (itemDetail != null ? tag != [] : tags != [] ) ?
            SizedBox(
              height: 30.0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child:  ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(width: 4.0),
                  scrollDirection: Axis.horizontal,
                  itemCount:  itemDetail != null ? tag.length : tags.length,
                  itemBuilder: (context, index) => ListTags(
                  index: index,
                  name: itemDetail != null ? tag[index] : tags[index],
                  )
                ),
              )
            ) : 
            const SizedBox()
          ]
        ),
      ),
    );
  }
  String coverType(String type) {
    switch (type) {
      case '1':
        return 'hardcover'.tr;
      case '2':
        return 'paperback'.tr;
      case '3':
        return 'pocket-paperback'.tr;
      default:
        return 'hardcover'.tr;
    }
  }
  String checkComma(String? date, int? publicaiton){
    if(date != null && publicaiton != null){
      return ',';
    }
    return '';
  }
}