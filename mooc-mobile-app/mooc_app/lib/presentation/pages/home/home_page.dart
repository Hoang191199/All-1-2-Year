import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:mooc_app/domain/entities/collection.dart';
import 'package:mooc_app/domain/entities/slide_show.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
// import 'package:mooc_app/presentation/controllers/blog/blog_controller.dart';
import 'package:mooc_app/presentation/controllers/category/category_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_controller.dart';

// import 'package:mooc_app/presentation/controllers/home/home_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
// import 'package:mooc_app/presentation/pages/home/widgets/blog_home_list.dart';
import 'package:mooc_app/presentation/pages/home/widgets/category_home_list.dart';
import 'package:mooc_app/presentation/pages/home/widgets/course_home_list.dart';
import 'package:mooc_app/presentation/pages/home/widgets/feature_home.dart';
import 'package:mooc_app/presentation/pages/home/widgets/home_banner.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:mooc_app/presentation/widgets/login_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  // final homeController = Get.find<HomeController>();
  final courseRecommendController = Get.find<CourseRecommendController>();
  final categoryController = Get.find<CategoryController>();
  // final blogController = Get.find<BlogController>();

  final List<SlideShow> listBannerData = [
    SlideShow(
        image_url:
            'https://mskill.mobiedu.vn/uploads/images/34112557_slider2_thumb.png',
        target_url: ''),
    SlideShow(
        image_url:
            'https://mskill.mobiedu.vn/uploads/images/35112059_slider3_thumb.jpg',
        target_url: ''),
  ];

  final List<String> altBanner = [
    "assets/images/home-banner-1.png",
    "assets/images/home-banner-2.png",
    "assets/images/home-banner-3.png",
    "assets/images/home-banner-4.png"
  ];

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Obx(() => loginController.isHandleLogging.value
        ? const Center(
            child: CircularLoadingIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                    // Obx(
                    //   () => homeController.isLoading.value ? const SizedBox(height: 180) : HomeBanner(listBannerData: homeController.homeData.value?.slide_show ?? []),
                    // ),
                    HomeBanner(
                      listBannerData: listBannerData,
                      altBanner: altBanner,
                    ),
                    // Obx(
                    //   () => homeController.isLoading.value ? const SizedBox() : const FeatureHome()
                    // ),
                    const FeatureHome(),
                    // Obx(
                    //   () => homeController.isLoading.value ? const SizedBox() : getColectionsWidget(),
                    // ),
                    Obx(
                      () => courseRecommendController.isLoading.value
                          ? const SizedBox()
                          : CourseHomeList(
                              title: AppLocalizations.of(context)!
                                  .recommended_course,
                              coursesRecommend:
                                  courseRecommendController.coursesData),
                    ),
                    // Obx(
                    //       () => blogController.isLoading.value
                    //       ? const SizedBox()
                    //       : BlogHomeList(
                    //       title: 'Blog',
                    //       data: blogController.fetch.value
                    //   ),
                    // ),
                    Obx(
                      () => categoryController.isLoading.value
                          ? const SizedBox()
                          : CategoryHomeList(
                              listCategory: categoryController.categoriesData),
                    )
                  ])),
                ),
                Obx(() => authController.isLoggedIn.value
                    ? const SizedBox(height: 30.0)
                    : LoginButton())
              ],
            )));
  }

  // getColectionsWidget() {
  //   final List<Collection>? listCollections = homeController.homeData.value?.collections;
  //   listCollections?.sort((a, b) => a.order - b.order);
  //   return ListView.builder(
  //     physics: const ClampingScrollPhysics(),
  //     padding: const EdgeInsets.only(top: 0.0),
  //     itemCount: listCollections?.length,
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       return CourseHomeList(
  //         collectionHomeItem: listCollections![index],
  //       );
  //     },
  //   );
  // }
}
