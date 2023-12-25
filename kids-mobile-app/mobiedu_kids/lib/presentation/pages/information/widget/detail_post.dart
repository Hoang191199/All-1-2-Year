import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/photo_grid.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

// ignore: must_be_immutable
class DetailPost extends StatelessWidget {
  DetailPost({super.key, required this.idPost});

  String idPost;

  final informationController = Get.find<InformationController>();
  final infoUser = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
        init: informationController,
        initState: (state) {
          informationController.getPostDetail(idPost, '0');
        },
        builder: (_) {
          final urls = <String>[];
            informationController.responsePostDetail.value?.data?.photos?.forEach((element) { 
              urls.add(urlImageNewPost(element.source ?? ''));
            });
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            }, 
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.only(top: 12.0),
                leading: Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(CupertinoIcons.back, color: AppColors.primary),
                  ),
                ),
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: 
                        informationController.responsePostDetail.value?.data?.post_author_picture == null ?
                        const Image(
                          image: AssetImage(
                            'assets/images/avatar-mac-dinh.png',
                          ),
                          fit: BoxFit.cover
                        )
                      : Image.network(
                          urlImageNewPost(informationController.responsePostDetail.value?.data?.post_author_picture ?? ''),
                          fit: BoxFit.cover
                        )
                      )
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${informationController.responsePostDetail.value?.data?.post_author_name}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ),
                            const WidgetSpan(child: SizedBox(width: 3.0)),
                            TextSpan(
                              text: 'đã đăng bài viết mới',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ),
                            const WidgetSpan(child: SizedBox(width: 3.0)),
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.arrow_right,
                                size: 16.0,
                                color: AppColors.pink,
                              ),
                            ),
                            const WidgetSpan(child: SizedBox(width: 3.0)),
                            TextSpan(
                              text: '${informationController.responsePostDetail.value?.data?.group_title}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ),
                            TextSpan(
                              text: '\n${informationController.responsePostDetail.value?.data?.group_title ?? ''}, ${informationController.getDay(informationController.responsePostDetail.value?.data?.time ?? '2023-07-19 00:00:00')}, ${informationController.formatDate(informationController.responsePostDetail.value?.data?.time ?? '2023-07-19 00:00:00')}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ),
                          ]
                        )
                      )
                    ),
                  ]
                ),
                backgroundColor: Colors.white,
                border: const Border(),
                ),
                child: 
                informationController.isLoadingPostDetail.value 
                ? const Center(
                    child: CircularLoadingIndicator(),
                  )
                :
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${informationController.responsePostDetail.value?.data?.text}',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      if(urls.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                        height: informationController.checkHeight(urls.length),
                        child: PhotoGrid(
                          imageUrls: urls,
                          legthImage: urls.length,
                          maxImages: 3,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    bool currentLikeValue = informationController.responsePostDetail.value?.data?.i_like ?? false;
                                    informationController.responsePostDetail.value?.data?.i_like = !currentLikeValue;
                                    String likeStatus = currentLikeValue ? 'unlike_post' : 'like_post';
                                    informationController.checkLikeDetail.value = likeStatus;
                                    informationController.actionLikeDetail(informationController.responsePostDetail.value?.data?.post_id ?? '0');
                                  },
                                  child: Icon(
                                    informationController.responsePostDetail.value?.data?.i_like == true ? CupertinoIcons.heart_fill : CupertinoIcons.heart ,
                                    size: 20.0,
                                    color: informationController.responsePostDetail.value?.data?.i_like == true ? const Color(0xFFF67882) : AppColors.grey,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(informationController.responsePostDetail.value?.data?.likes ?? '',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                )
                              ],
                            );
                          },),
                          Obx(() {
                            return Text('${informationController.responsePostDetail.value?.data?.comments ?? '0'} Bình luận',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            );
                          },),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: ListView.builder(
                        itemCount: informationController.responsePostDetail.value?.comment?.length,
                        itemBuilder: (context, index) =>
                          Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 46.0,
                                            height: 46.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: 
                                              infoUser.responseManagerData.value?.data?.children?[0].child_picture == '' ?
                                              Image.asset('assets/images/avatar-mac-dinh.png',
                                                fit: BoxFit.contain
                                                )
                                              : Image.network('${urlImage()}''${informationController.responsePostDetail.value?.comment?[index].author_picture ?? ''}',
                                                fit: BoxFit.contain
                                              )
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: widthScreen,
                                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.lightGrey,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('${informationController.responsePostDetail.value?.comment?[index].author_name}',
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.black,
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w700,
                                                            height: 1.5
                                                          ),
                                                        ),
                                                      ),
                                                      Text('${informationController.responsePostDetail.value?.comment?[index].text}',
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.black,
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 5,
                                                      )
                                                    ]
                                                  ),
                                                ),
                                                const SizedBox(height: 6.0),
                                                Row(
                                                  children: [
                                                    Text('${informationController.responsePostDetail.value?.comment?[index].time}',
                                                      style: GoogleFonts.raleway(
                                                        textStyle: TextStyle(
                                                          color: AppColors.grey,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    GestureDetector(
                                                      child: Text('Thích',
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.grey,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    GestureDetector(
                                                      child: Text('Trả lời',
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.grey,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    informationController.responsePostDetail.value?.comment?[index].delete_comment == true ?
                                    GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.grey,
                                        size: 16.0,
                                      ),
                                    )
                                  : const SizedBox()
                                  ],
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 46.0,
                            height: 46.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: 
                              infoUser.responseManagerData.value?.data?.children?[0].child_picture == '' ?
                              Image.asset('assets/images/avatar-mac-dinh.png',
                                fit: BoxFit.contain
                                )
                              : Image.network('${urlImage()}''${infoUser.responseManagerData.value?.data?.children?[0].child_picture ?? ''}',
                                fit: BoxFit.contain
                              )
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: const BorderRadius.all(Radius.circular(20.0))
                              ),
                              child: Row( 
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CupertinoTextField(
                                      controller: informationController.commentDetail,
                                      placeholder: 'Viết bình luận ....',
                                      placeholderStyle: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      decoration: const BoxDecoration()
                                    )
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      informationController.actionCommentDetail(informationController.responsePostDetail.value?.data?.post_id ?? '0');
                                    },
                                    child: Image.asset(
                                      'assets/images/send.png',
                                      width: 24.0,
                                      height: 24.0,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ]
                              )
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
            );
      }
    );
  }

}
