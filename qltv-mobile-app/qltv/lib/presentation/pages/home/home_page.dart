import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/pages/home/widgets/home_banner.dart';
import 'package:qltv/presentation/pages/home/widgets/home_focus.dart';
import 'package:qltv/presentation/pages/home/widgets/home_user_info.dart';
import 'package:qltv/presentation/widgets/circular_loading_indicator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.find<HomeController>();
  final loginController = Get.find<LoginController>();
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
        init: homeController,
        initState: (state) {
          homeController.fetchData();
        },
        builder: (_) {
          final sectionCarousel = homeController.homeData.value?.page_sections
              ?.firstWhere(
                  (element) => element.template_type == TemplateType.carousel);
          final sectionFocus = homeController.homeData.value?.page_sections
              ?.firstWhere(
                  (element) => element.template_type == TemplateType.focus);
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Container(
              padding: EdgeInsets.only(top: statusBarHeight),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: HomeUserInfo(),
                    ),
                    Obx(() => homeController.isLoading.value
                        ? SizedBox(
                            height: heightScreen -
                                statusBarHeight -
                                20.0 -
                                40.0 -
                                kBottomNavigationBarHeight -
                                bottomPadding,
                            child: const Center(
                              child: CircularLoadingIndicator(),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: HomeBanner(
                                  listBannerData:
                                      sectionCarousel?.metadata?.items ?? [],
                                  carouselController: carouselController,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 44.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: HomeFocus(
                                    listModelFocus:
                                        sectionFocus?.metadata?.model ?? []),
                              )
                            ],
                          ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
