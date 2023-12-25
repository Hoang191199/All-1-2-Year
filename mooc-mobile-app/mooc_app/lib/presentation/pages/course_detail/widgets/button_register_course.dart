import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/coupon_code/coupon_code_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_combo_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_scroll_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_combo_controller.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_binding.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_controller.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';
import 'package:mooc_app/presentation/pages/register_course/register_course_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonRegisterCourse extends StatelessWidget {
  ButtonRegisterCourse({
    super.key,
    this.courseInfo,
    this.type,
    this.courseType
  });

  final Course? courseInfo;
  final String? type;
  final String? courseType;

  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  final courseDetailController = Get.find<CourseDetailController>();
  final addFreeCourseController = Get.find<AddFreeCourseController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: addFreeCourseController.isLoading.value ? null : () {
          handlePressRegister(context);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: type == "bottom" ? const BorderRadius.all(Radius.circular(2.0)) : const BorderRadius.all(Radius.circular(6.0))
          ),
          elevation: 0.0,
          backgroundColor: Colors.red,
          disabledBackgroundColor: Colors.white54,
          textStyle: type == "bottom" 
            ? const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white) 
            : const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        child: Container(
          padding: type == "bottom" ? const EdgeInsets.symmetric(vertical: 10.0) : const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(AppLocalizations.of(context)!.resgiterCourse.toUpperCase())
        )
      )
    );
  }

  void handlePressRegister(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (authController.isLoggedIn.value) {
      if (context.mounted) {
        register(context);
      }
    } else {
      await loginController.authenticate();
      if (authController.isLoggedIn.value) {
        await courseDetailController.fetchData(courseInfo?.id ?? 0, courseInfo?.slug ?? '');
        await cartController.fetchCartData();
        if (!(courseDetailController.courseData.value?.isMapping ?? false)) {
          if (context.mounted) {
            register(context);
          }
        }
      }
    }
  }

  void register(BuildContext context) async {
    if (courseInfo?.sale_price == 0) {
      try {
        if (courseType == 'courseCombo') {
          await addFreeCourseController.addFreePackage(courseInfo?.id ?? 0);
        } else {
          await addFreeCourseController.addFreeCourse(courseInfo?.id ?? 0);
        }
        if (!(addFreeCourseController.responseData.value?.error ?? false)) {
          final initPageTabController = Get.put(InitPageTabController());
          initPageTabController.changeIndexTab(2);
          if (context.mounted) {
            await refreshAfterRegisterSuccess(context);
          }
          Get.to(() => InitPage());
          if (context.mounted) {
            showSnackbar(SnackbarType.success, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.resgiterCourseSuccess);
          }
        } else {
          if (context.mounted) {
            showSnackbar(SnackbarType.error, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.resgiterCourseFalse);
          }
        }
      } catch (error) {
        if (context.mounted) {
          showSnackbar(SnackbarType.error, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.resgiterCourseFalse);
        }
      }
    } else if ((courseInfo?.sale_price ?? 0.0) > 0) {
      List<Course> listCourseCart = [];
      listCourseCart.add(courseInfo!);
      CouponCodeBinding().dependencies();
      Get.to(() => RegisterCoursePage(listCourseCart: listCourseCart));
    }
  }

  refreshAfterRegisterSuccess(BuildContext context) async {
    await Get.delete<CourseDetailController>();
    await Get.delete<CourseComboDetailController>();
    await Get.delete<CourseDetailScrollController>();
    await Get.delete<CourseComboController>();
    await Get.delete<LearningCourseListController>();
    // LearningCourseListBinding().dependencies();
    // final learningCourseListController = Get.find<LearningCourseListController>();
    // await learningCourseListController.fetchData();
    if (context.mounted) {
      await handleRidirectToLearningCoursePage(context);
    }
  }
}