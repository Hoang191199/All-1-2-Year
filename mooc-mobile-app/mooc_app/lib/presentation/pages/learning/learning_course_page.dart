import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/category/category_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:mooc_app/presentation/widgets/list_category.dart';
import 'package:mooc_app/presentation/widgets/login_button.dart';
import 'package:mooc_app/presentation/widgets/paid_course.dart';

class LearningCoursePage extends StatelessWidget {
  LearningCoursePage({super.key});

  final learningCourseListController = Get.find<LearningCourseListController>();
  final scrollController = ScrollController();
  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
        init: learningCourseListController,
        initState: (state) async {
          // await learningCourseListController.fetchData();
          // if (learningCourseListController.responseData.value?.error ?? false) {
          //   if (learningCourseListController.responseData.value?.code == ResponseCode.loginSession) {
          //     if (context.mounted) {
          //       showLoginSessionDialog(context);
          //     }
          //     await learningCourseListController.fetchData();
          //   } else {
          //     if (context.mounted) {
          //       showSnackbar(SnackbarType.error, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.error);
          //     }
          //   }
          // }
          scrollController.addListener(scrollListener);
        },
        didUpdateWidget: (old, newState) {
          scrollController.addListener(scrollListener);
        },
        dispose: (state) {
          scrollController.removeListener(scrollListener);
        },
        builder: (_) {
          return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                automaticallyImplyLeading: false,
                middle: Text('Vào học'),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: (statusBarHeight +
                        const CupertinoNavigationBar().preferredSize.height)),
                child: loginController.isHandleLogging.value
                    ? const Center(
                        child: CircularLoadingIndicator(),
                      )
                    : authController.isLoggedIn.value
                        ? learningCourseListController.isLoading.value
                            ? const Center(
                                child: CircularLoadingIndicator(),
                              )
                            : learningCourseListController.coursesData.isEmpty
                                ? const Center(
                                    child: Text(
                                        'Bạn chưa đăng ký khóa học nào!',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  )
                                : ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        bottom: kBottomNavigationBarHeight +
                                            bottomPadding +
                                            10.0,
                                        right: 10.0),
                                    itemCount: learningCourseListController
                                        .coursesData.length,
                                    controller: scrollController,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10.0),
                                    itemBuilder: (context, index) {
                                      return CoursePaid(
                                        widthItem: widthScreen,
                                        courseItem: learningCourseListController
                                            .coursesData[index],
                                      );
                                    })
                        : contentNoLogin(context),
              ));
        });
  }

  Widget contentNoLogin(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/video.jpg',
                width: widthScreen,
                height: 180,
                fit: BoxFit.contain,
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: const Text(
                  "Chia sẻ kiến thức và kinh nghiệm thực tế đến hàng triệu người",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: const Text(
                  "Học bất cứ lúc nào bất cứ nơi đâu",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                  child: Row(
                    children: const [
                      Text("Danh mục khóa học",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500))
                    ],
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListCategory(
                  length:
                      categoryController.categoryResponse.value?.items?.length,
                  cate: categoryController.categoryResponse.value?.items,
                ),
              )
            ],
          ),
        )),
        LoginButton()
      ],
    );
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      learningCourseListController.loadMore();
    }
  }
}
