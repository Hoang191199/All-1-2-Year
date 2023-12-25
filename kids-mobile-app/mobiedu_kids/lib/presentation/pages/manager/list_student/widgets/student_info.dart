import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class StudentInfo extends StatelessWidget {
  StudentInfo({super.key});

  final childController = Get.find<ChildController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        childController.child_info.value?.child_picture != null && (childController.child_info.value?.child_picture?.isNotEmpty ?? false)
          ? ClipOval(
            child: CachedNetworkImage(
              imageUrl: childController.child_info.value?.child_picture ?? '',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 48.0,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => noAvatar(),
              errorWidget: (context, url, error) => noAvatar(),
            ),
          )
          : noAvatar(),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${childController.child_info.value?.child_name}",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: 16.0, color: AppColors.black, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Text(
                    "Ngày sinh : ",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                    ),
                  ),
                  Text(
                    "${childController.child_info.value?.birthday}",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 14.0, color: AppColors.black, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Row(
                    children: [
                      childController.child_info.value?.gender == "male"
                        ? const ClipOval(
                          child: Image(
                            height: 16.0,
                            width: 16.0,
                            image: AssetImage("assets/images/active.png"),
                            fit: BoxFit.cover
                          ),
                        )
                        : const ClipOval(
                          child: Image(
                            height: 16.0,
                            width: 16.0,
                            image: AssetImage("assets/images/inactive.png"),
                            fit: BoxFit.cover
                          ),
                        ),
                      const SizedBox(width: 8.0),
                      Text(
                        "Nam",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: 14.0, color: AppColors.black, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: [
                      childController.child_info.value?.gender == "male"
                        ? const ClipOval(
                          child: Image(
                            height: 16.0,
                            width: 16.0,
                            image: AssetImage("assets/images/inactive.png"),
                            fit: BoxFit.cover
                          ),
                        )
                        : const ClipOval(
                          child: Image(
                            height: 16.0,
                            width: 16.0,
                            image: AssetImage("assets/images/active.png"),
                            fit: BoxFit.cover
                          ),
                        ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Nữ",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: 14.0, color: AppColors.black, fontWeight: FontWeight.w500),
                      ),
                    )
                  ])
                ],
              )
            ],
          )
        )
      ],
    );
  }

  Widget noAvatar() {
    return const ClipOval(
      child: Image(
        height: 96.0,
        width: 96.0,
        image: AssetImage("assets/images/avatar-mac-dinh.png"),
        fit: BoxFit.cover
      ),
    );
  }
}