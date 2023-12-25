import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/config/app_text_styles.dart';
import 'package:qltv/domain/entities/epub/epub_content_type.dart';

void showAlertDialog(BuildContext context, String? title, String content) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(title ?? 'info'.tr,
                style: const TextStyle(color: Colors.black)),
            content: Text(content, style: const TextStyle(color: Colors.black)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        });
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'info'.tr, style: AppTextStyles.titleDialog),
        content: Text(content, style: AppTextStyles.contentDialog),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            style: TextButton.styleFrom(
                textStyle: TextStyle(color: AppColors.primaryBlue)),
            child: Text('OK', style: AppTextStyles.actionOKDialog),
          )
        ],
      ),
    );
  }
}

void showSnackbar(String type, String title, String content) {
  Get.snackbar(
    title,
    content,
    icon: const Icon(CupertinoIcons.check_mark_circled, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: type == SnackbarType.success
        ? Colors.green
        : type == SnackbarType.error
            ? Colors.red
            : AppColors.primaryBlue,
    borderRadius: 10,
    colorText: Colors.white,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
}

List<Widget> getListStarViewOfFive(double starFillNumber) {
  List<Widget> starList = [];
  var starCheck = 0.0;
  if (0 > starFillNumber) {
    starCheck = 0;
  } else if (5 < starFillNumber) {
    starCheck = 5;
  } else {
    starCheck = starFillNumber;
  }
  var starCheckFloor = starCheck.floor();
  var starCheckCeil = starCheck.ceil();
  for (int i = 1; i <= starCheckFloor; i++) {
    starList
        .add(Icon(Icons.star_rounded, color: AppColors.starYellow, size: 14));
  }
  if (starCheckCeil > starCheckFloor) {
    starList.add(
        Icon(Icons.star_half_rounded, color: AppColors.starYellow, size: 14));
  }
  for (int i = 1; i <= (5 - starCheckCeil); i++) {
    starList.add(
        Icon(Icons.star_border_rounded, color: AppColors.starYellow, size: 14));
  }
  return starList;
}

EpubContentType getContentTypeByContentMimeType(String contentMimeType) {
  switch (contentMimeType.toLowerCase()) {
    case MediaType.application_xhtml_xml:
      return EpubContentType.XHTML_1_1;
    case MediaType.application_x_dtbook_xml:
      return EpubContentType.DTBOOK;
    case MediaType.application_x_dtbncx_xml:
      return EpubContentType.DTBOOK_NCX;
    case MediaType.text_x_oeb1_document:
      return EpubContentType.OEB1_DOCUMENT;
    case MediaType.application_xml:
      return EpubContentType.XML;
    case MediaType.text_css:
      return EpubContentType.CSS;
    case MediaType.text_x_oeb1_css:
      return EpubContentType.OEB1_CSS;
    case MediaType.image_gif:
      return EpubContentType.IMAGE_GIF;
    case MediaType.image_jpeg:
      return EpubContentType.IMAGE_JPEG;
    case MediaType.image_png:
      return EpubContentType.IMAGE_PNG;
    case MediaType.image_svg_xml:
      return EpubContentType.IMAGE_SVG;
    case MediaType.font_truetype:
      return EpubContentType.FONT_TRUETYPE;
    case MediaType.font_opentype:
      return EpubContentType.FONT_OPENTYPE;
    case MediaType.application_vnd_ms_opentype:
      return EpubContentType.FONT_OPENTYPE;
    default:
      return EpubContentType.OTHER;
  }
}

T enumFromIndex<T extends Enum>(List<T> values, dynamic index, {T? def}) {
  if (index is! int) {
    index = def?.index ?? 0;
  }
  
  if (index > 0 && index < values.length) {
    return values[index];
  }

  return def ?? values.first;
}
