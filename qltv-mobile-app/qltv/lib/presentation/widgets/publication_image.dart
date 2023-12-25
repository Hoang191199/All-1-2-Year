import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/bookcase.dart';

class PublicationImage extends StatelessWidget {
  const PublicationImage({
    super.key,
    required this.widthImage,
    required this.heightImage,
    this.imageUrl,
    required this.isShowDigital,
    required this.isShowInfo,
    this.bookcase,
  });

  final double widthImage;
  final double heightImage;
  final String? imageUrl;
  final bool isShowDigital;
  final bool isShowInfo;
  final Bookcase? bookcase;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onLongPress: !isShowInfo
              ? null
              : () {
                  handleLongPressImage(context);
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

  Future<void> handleLongPressImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          double widthScreen = MediaQuery.of(context).size.width;

          return Dialog(
            alignment: Alignment.center,
            insetPadding: const EdgeInsets.only(left: 28.0, right: 28.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: widthScreen - 28.0 - 28.0,
              // height: 376.0,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'publication-info'.tr,
                    style: GoogleFonts.kantumruy(
                      textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      PublicationImage(
                        widthImage: 100.0,
                        heightImage: 144.0,
                        imageUrl: imageUrl,
                        isShowDigital: true,
                        isShowInfo: false,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                          child: Container(
                        constraints: const BoxConstraints(minHeight: 144),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(bookcase?.title ?? '',
                                    style: GoogleFonts.kantumruy(
                                        textStyle: TextStyle(
                                            fontSize: 22.0,
                                            height: 1.36,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor('333333'))),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 8.0),
                                Text(
                                    '${bookcase?.authors ?? ''} (${bookcase?.publication_year ?? 0})',
                                    style: GoogleFonts.kantumruy(
                                        textStyle: TextStyle(
                                            fontSize: 14.0,
                                            height: 1.4,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('333333'))),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                            bookcase?.metadata?.keywords == null ||
                                    (bookcase?.metadata?.keywords?.isEmpty ??
                                        false)
                                ? Container()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                        color: HexColor('D9E9F2'),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Text(
                                      bookcase?.metadata?.keywords ?? '',
                                      style: GoogleFonts.kantumruy(
                                          textStyle: TextStyle(
                                              fontSize: 14.0,
                                              height: 1.4,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryBlue)),
                                    )),
                          ],
                        ),
                      ))
                    ],
                  ),
                  bookcase?.metadata?.intro_pub == null ||
                          (bookcase?.metadata?.intro_pub?.isEmpty ?? false)
                      ? Container()
                      : Column(
                          children: [
                            const SizedBox(height: 24.0),
                            Container(
                              constraints:
                                  const BoxConstraints(maxHeight: 200.0),
                              child: SingleChildScrollView(
                                child: Html(
                                  data: bookcase?.metadata?.intro_pub ?? '',
                                  style: {
                                    "body": Style(fontSize: FontSize(14.0)),
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          );
        });
  }
}
