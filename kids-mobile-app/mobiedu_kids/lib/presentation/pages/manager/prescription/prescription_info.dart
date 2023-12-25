import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/domain/entities/prescription/details.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';

class PrescriptionInfo extends StatelessWidget {
  PrescriptionInfo({
    super.key,
    this.end,
    this.medicine_list,
    this.guide,
    this.image,
    this.details
  });

  final String? end;
  final String? medicine_list;
  final String? guide;
  final String? image;
  final List<Details>? details;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widthScreen,
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFDFF1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                'Ngày hết hạn: $end',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: widthScreen,
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFDFF1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                'Thuốc: $medicine_list',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: widthScreen,
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFDFF1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                'HDSD: $guide',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: widthScreen,
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFDFF1),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    'Lịch sử uống',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: details?.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      '${details?[index].created_at} | ${details?[index].user_fullname}',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              showImage(context, image, widthScreen, heightScreen);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
              child: Text(
                'Ảnh đơn thuốc',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.5
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

showImage(context,String? image, double widthScreen, double heightScreen){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20.0)),
          child: Container(
          constraints: const BoxConstraints(maxHeight: 350),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: image != null && image != '' ? image.startsWith('http')
              ? CachedNetworkImage(
                  imageUrl:  image,
                  width: widthScreen,
                  height: heightScreen,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                  errorWidget: (context, url, error) => const AvatarError(),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                image,
                fit: BoxFit.cover,
                width: widthScreen,
                height: heightScreen,
              )
              : Image.asset(
                'assets/images/no_image_publication.png',
                  fit: BoxFit.cover,
                  width: widthScreen,
                  height: heightScreen,
              ),
            )
          ),
        ),
      );
    }
  );
}