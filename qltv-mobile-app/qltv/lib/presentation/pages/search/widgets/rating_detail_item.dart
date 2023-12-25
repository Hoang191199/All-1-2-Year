import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/search.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    this.itemDetail,
    this.publicationDetail
  });

  final Search? itemDetail;
  final Publication? publicationDetail; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: itemDetail != null 
        ? (itemDetail?.object_type == "publications" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround)
        : (publicationDetail?.type == "publications" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround),
        children: itemRating(itemDetail, publicationDetail)
      )
    );
  }

  List<Widget> itemRating(itemDetail, publicationDetail) {
    List<Widget> itemArr = [];
    if (itemDetail != null ? itemDetail?.object_type == "publications" : publicationDetail?.type == "publications") {
      itemArr.add(
        Column(
          children: [
            Container(
              width: 48, 
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: HexColor('D9E9F2')
                ) 
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/svg/star.svg',
                  width: 22,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('4.9',
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  color: HexColor('333333')
                )
              ),                              
            ),
            Text('vote'.tr,
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                  color: HexColor('343232')
                ), 
              )                             
            )
          ],
        ),
      );
    }
    itemArr.add(
      Column(
        children: [
          Container(
            width: 48, 
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: HexColor('D9E9F2')
              ) 
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/svg/book.svg',
                width: 22,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(itemDetail != null ? '${itemDetail?.print_length}' : '${publicationDetail?.metadata?.print_length}',
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(
                fontSize: 16,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: HexColor('333333')
              )
            ),                              
          ),
          Text('page'.tr,
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(
                fontSize: 14,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: HexColor('343232')
              ), 
            )                             
          )
        ],
      ),  
    );
    itemArr.add(
      Column(
        children: [
          Container(
            width: 48, 
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: HexColor('D9E9F2')
              ) 
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/svg/view.svg',
                width: 22,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(itemDetail != null ? '${itemDetail?.seen ?? 0}' : '${publicationDetail?.seen ?? 0}',
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(
                fontSize: 16,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: HexColor('333333')
              )
            ),                              
          ),
          Text('view'.tr,
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(
                fontSize: 14,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: HexColor('343232')
              ), 
            )                             
          )
        ],
      ),
    );
    return itemArr;
  }
}