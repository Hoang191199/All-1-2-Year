import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/photo_grid.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/video_post.dart';

class SocialInfo extends StatelessWidget {
  SocialInfo({super.key});

  final informationController = Get.find<InformationController>();
  final infoUser = Get.find<SplashScreenController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    PrescriptionChildBinding().dependencies();
    double widthScreen = MediaQuery.of(context).size.width;

    return Column(
      children: List.generate(
        informationController.responseNewPost.value?.data?.posts?.length ?? 5, (index) {
          final urls = <String>[];
          final video = informationController.responseNewPost.value?.data?.posts?[index].video;
          informationController.responseNewPost.value?.data?.posts?[index].photos?.forEach((element) { 
            urls.add(element.source ?? '');
          });
          return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.only(top: 12.0, bottom:16.0, left: 20.0, right: 20.0),
                decoration: ShapeDecoration(
                  color: AppColors.lightPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10.0,
                      offset: Offset(0, 4.0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        NewsFeedBinding().dependencies();
                        ShowPageBinding().dependencies();
                        ShowGroupBinding().dependencies();
                        SavedPostsBinding().dependencies();
                        HomePageBinding('').dependencies();
                        Get.to(() => NewsFeedPostDetailPage(
                            from: PostNewsFrom.newsFeedPage,
                            postId: informationController.responseNewPost.value?.data?.posts?[index].post_id ?? '0',
                          )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 46.0,
                            height: 46.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: 
                              informationController.responseNewPost.value?.data?.posts?[index].post_author_picture == null ?
                              const Image(
                                image: AssetImage(
                                  'assets/images/avatar-mac-dinh.png',
                                ),
                                fit: BoxFit.cover
                              )
                            : Image.network(
                                (informationController.responseNewPost.value?.data?.posts?[index].post_author_picture ?? ''),
                                fit: BoxFit.cover
                              )
                            )
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: informationController.responseNewPost.value?.data?.posts?[index].post_author_name ?? '',
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
                                text: informationController.responseNewPost.value?.data?.posts?[index].group_title ?? '',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ),
                              TextSpan(
                                text: '\n${informationController.responseNewPost.value?.data?.posts?[index].group_title ?? ''}, ${informationController.getDay(informationController.responseNewPost.value?.data?.posts?[index].time ?? '2023-07-19 00:00:00')}, ${informationController.formatDate(informationController.responseNewPost.value?.data?.posts?[index].time ?? '2023-07-19 00:00:00') }',
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
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: (){
                    NewsFeedBinding().dependencies();
                    ShowPageBinding().dependencies();
                    ShowGroupBinding().dependencies();
                    SavedPostsBinding().dependencies();
                    HomePageBinding('').dependencies();
                    Get.to(() => NewsFeedPostDetailPage(
                        from: PostNewsFrom.newsFeedPage,
                        postId: informationController.responseNewPost.value?.data?.posts?[index].post_id ?? '0',
                      )
                    );
                  },
                  child: Html(
                    data: informationController.responseNewPost.value?.data?.posts?[index].text ?? '',
                    style: {
                      'body': Style(
                        lineHeight: const LineHeight(1.6),
                        fontSize: FontSize(14.0),
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontFamily: 'Raleway',
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 1
                      )
                    },
                  ),
                ),
                if(urls.isNotEmpty) 
                GestureDetector(
                  onTap: (){
                    NewsFeedBinding().dependencies();
                    ShowPageBinding().dependencies();
                    ShowGroupBinding().dependencies();
                    SavedPostsBinding().dependencies();
                    HomePageBinding('').dependencies();
                    Get.to(() => NewsFeedPostDetailPage(
                        from: PostNewsFrom.newsFeedPage,
                        postId: informationController.responseNewPost.value?.data?.posts?[index].post_id ?? '0',
                      )
                    );
                  },
                  child: Container(
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
                      id: informationController.responseNewPost.value?.data?.posts?[index].post_id,
                      type: 'detail'
                    ),
                  ),
                )
              else if(video?.source != '' && video?.source != null) 
               Container(
                  width: widthScreen,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    color: Colors.black
                  ),
                  child: VideoPost(
                    filePath: video?.source ?? '',
                    fileType: VideoFileType.network,
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
                              bool currentLikeValue = informationController.responseNewPost.value?.data?.posts?[index].i_like ?? false;
                              informationController.responseNewPost.value?.data?.posts?[index].i_like = !currentLikeValue;
                              String likeStatus = currentLikeValue ? 'unlike_post' : 'like_post';
                              informationController.checkLike[index] = likeStatus;
                              informationController.actionLike(index);
                            },
                            child: Icon(
                              informationController.responseNewPost.value?.data?.posts?[index].i_like == true ? CupertinoIcons.heart_fill : CupertinoIcons.heart ,
                              size: 20.0,
                              color: informationController.responseNewPost.value?.data?.posts?[index].i_like == true ? const Color(0xFFF67882) : AppColors.grey,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(informationController.responseNewPost.value?.data?.posts?[index].likes ?? '',
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
                      return Text('${informationController.responseNewPost.value?.data?.posts?[index].comments ?? '0'} Bình luận',
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
                        store.userFromStorage?.user_picture == '' || store.userFromStorage?.user_picture == null?
                        Image.asset('assets/images/avatar-mac-dinh.png',
                          fit: BoxFit.cover
                          )
                        : Image.network(store.userFromStorage?.user_picture ?? '',
                          fit: BoxFit.cover
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
                                controller: informationController.checkComment[index],
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
                                informationController.actionComment(index);
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
              ]
            ),
          );
        } 
      )
    );
  }

}
