import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonAddToCart extends StatelessWidget {
  ButtonAddToCart({
    super.key,
    this.courseInfo,
  });

  final Course? courseInfo;

  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  final cartController = Get.find<CartController>();
  final courseDetailController = Get.find<CourseDetailController>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        handlePressAddToCart(context);
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
        disabledBackgroundColor: Colors.white54,
        textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.cart_badge_plus, size: 22.0),
            const SizedBox(width: 10.0),
            Text(AppLocalizations.of(context)!.addToCart.toUpperCase())
          ],
        )
      )
    );
  }
  
  Future<void> handlePressAddToCart(BuildContext context) async {
    if (authController.isLoggedIn.value) {
      addToCart(context);
    } else {
      await loginController.authenticate();
      if (authController.isLoggedIn.value) {
        await courseDetailController.fetchData(courseInfo?.id ?? 0, courseInfo?.slug ?? '');
        await cartController.fetchCartData();
        if (context.mounted) {
          addToCart(context);
        }
      }
    }
  }

  void addToCart(BuildContext context) async {
    UserSSO? userLogin = authController.userLogin;
    var isDuplicate = cartController.listCart.any((element) => element?.course_id == courseInfo?.id && element?.user_id == (userLogin?.id ?? 1));
    if (!isDuplicate) {
      await cartController.addCourseToCart(courseInfo!);
      if (context.mounted) {
        showSnackbar(SnackbarType.success, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.addToCartSuccess);
      }
    } else {
      showSnackbar(SnackbarType.success, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.addToCartFalse);
    }
  }
}