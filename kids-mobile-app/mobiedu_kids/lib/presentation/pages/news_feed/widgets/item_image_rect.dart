import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';

class ItemImageRect extends StatelessWidget {
  const ItemImageRect({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    this.borderRadius,
  });

  final String imageUrl;
  final double width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius == null 
        ? const BorderRadius.all(Radius.circular(10.0))
        : BorderRadius.all(Radius.circular(borderRadius ?? 0)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: (height ?? 0) > 0 ? height : null,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: (height ?? 0) > 0 ? height : (width * 9 / 16),
            color: HexColor('D8D8D8'),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported_outlined, size: context.responsive(30.0), color: HexColor('6F6F6F')),
                    const SizedBox(height: 10.0),
                    Text(
                      'Hình ảnh bị lỗi',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}