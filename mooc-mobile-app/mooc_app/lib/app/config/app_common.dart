import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/app/config/app_text_styles.dart';
import 'package:mooc_app/domain/entities/document_file.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/category/category_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_controller.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_binding.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_document_list.dart';

import 'app_colors.dart';

NumberFormat getCurrencyFormatVN() {
  return NumberFormat("#,##0", "vi_VN");
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
  for(int i = 1; i <= starCheckFloor; i++) {
    starList.add(Icon(CupertinoIcons.star_fill, color: AppColors.starYellow, size: 14));
  }
  if (starCheckCeil > starCheckFloor) {
    starList.add(Icon(CupertinoIcons.star_lefthalf_fill, color: AppColors.starYellow, size: 14));
  }
  for(int i = 1; i <= (5 - starCheckCeil); i++) {
    starList.add(Icon(CupertinoIcons.star, color: AppColors.starYellow, size: 14));
  }
  return starList;
}

String getCharacterAvatar(String text) {
  if (text.isNotEmpty && text.trim().isNotEmpty) {
    var splitArr = text.split(' ');
    return splitArr.last[0];
  }
  return 'a';
}

void showAlertDialog(BuildContext context, String? title, String content) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? AppLocalizations.of(context)!.notifications, 
            style: const TextStyle(color: Colors.black)
          ),
          content: Text(content, style: const TextStyle(color: Colors.black)),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.yes, 
                style: const TextStyle(color: Colors.black)
              ),
            ),
          ],
        );
      }
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? AppLocalizations.of(context)!.notifications, style: AppTextStyles.titleDialog),
        content: Text(content, style: AppTextStyles.contentDialog),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            style: TextButton.styleFrom(textStyle: TextStyle(color: AppColors.primaryBlue)),
            child: Text(AppLocalizations.of(context)!.yes.toUpperCase(), style: AppTextStyles.actionOKDialog),
          )
        ],
      ),
    );
  }
}

void showLoginSessionDialog(BuildContext context) {
  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context)!.notifications, 
            style: const TextStyle(color: Colors.black)
          ),
          content: Text(AppLocalizations.of(context)!.exitRequest),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.cancel, 
                style: const TextStyle(color: Colors.black)
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                authController.logout();
                loginController.authenticate();
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.yes, 
                style: const TextStyle(color: Colors.black)
              ),
            ),
          ],
        );
      }
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.notifications),
        titleTextStyle: AppTextStyles.titleDialog,
        content: Text(AppLocalizations.of(context)!.exitRequest),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(textStyle: const TextStyle(color: Colors.black)),
            child: Text(
              AppLocalizations.of(context)!.cancel, 
              style: AppTextStyles.actionCancelDialog
            ),
          ),
          TextButton(
            onPressed: () {
              authController.logout();
              loginController.authenticate();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(textStyle: const TextStyle(color: Colors.black)),
            child: Text(
              AppLocalizations.of(context)!.yes, 
              style: AppTextStyles.actionOKDialog
            ),
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
    backgroundColor: type == SnackbarType.success ? Colors.green : type == SnackbarType.error ? Colors.red : AppColors.primaryBlue,
    borderRadius: 10,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email);
}

bool isValidPhone(String phone) {
  return RegExp(r"^(?:(0|\+84|84)[3|5|7|8|9])?[0-9]{8}$").hasMatch(phone);
}

void reloadHomeWhenBackFromOther() {
  final previousRoute = Get.previousRoute;
  if (previousRoute != '/CourseListPage') {
    final initPageTabController = Get.put(InitPageTabController());
    final currentInitPageIndex = initPageTabController.cupertinoTabController.index;
    if (currentInitPageIndex == 0) {
      CourseRecommendBinding().dependencies();
      final courseRecommendController = Get.find<CourseRecommendController>();
      courseRecommendController.fetchData(0, 6);
    } else if (currentInitPageIndex == 2) {
      final authController = Get.find<AuthController>();
      if (authController.isLoggedIn.value) {
        LearningCourseListBinding().dependencies();
        final learningCourseListController = Get.find<LearningCourseListController>();
        learningCourseListController.fetchData();
      } else {
        CategoryBinding().dependencies();
      }
    }
  }
}

Future<void> handlePressMenuLesson(BuildContext context, List<DocumentFile> documentFiles) {
  double widthScreen = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.topRight,
        insetPadding: EdgeInsets.only(top: 10.0, right: 10.0, left: widthScreen - 150.0 - 10.0),
        backgroundColor: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.to(() => CourseLessonDocumentList(documentFiles: documentFiles));
          },
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text("Tài liệu", style: TextStyle(fontSize: 15.0, color: Colors.black)),
          ),
        )
      );
    }
  );
}

Future<void> handleRidirectToLearningCoursePage(BuildContext context) async {
  LearningCourseListBinding().dependencies();
  final learningCourseListController = Get.find<LearningCourseListController>();
  await learningCourseListController.fetchData();
  if (learningCourseListController.responseData.value?.error ?? false) {
    if (learningCourseListController.responseData.value?.code == ResponseCode.loginSession) {
      final authController = Get.find<AuthController>();
      final loginController = Get.put(LoginController());
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
              title:  Text(AppLocalizations.of(context)!.notifications, 
              style: const TextStyle(color: Colors.black)),
              content: Text(AppLocalizations.of(context)!.exitRequest),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.cancel, 
                  style: const TextStyle(color: Colors.black)),
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    await authController.logout();
                    await loginController.authenticate();
                    await learningCourseListController.fetchData();
                  },
                  child: Text(AppLocalizations.of(context)!.yes, 
                  style: const TextStyle(color: Colors.black)),
                ),
              ],
            );
          }
        );
      }
    } else {
      if (context.mounted) {
        showSnackbar(SnackbarType.error, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.error);
      }
    }
  }
}