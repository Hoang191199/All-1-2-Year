import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/cart.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/button_register_course.dart';
import 'package:mooc_app/presentation/pages/register_course/register_course_page.dart';

class RegisterCourseBottom extends StatelessWidget {
  RegisterCourseBottom({
    Key? key,
    this.courseInfo,
    this.courseType
  }) : super(key: key);

  final Course? courseInfo;
  final String? courseType;

  final currencyFormat = getCurrencyFormatVN();
  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Container(
      padding: EdgeInsets.only(left: 30.0, top: 6.0, right: 30.0, bottom: 6.0 + bottomPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 1.0),
                    child: Text(
                      currencyFormat.format(courseInfo?.sale_price ?? 0.0), 
                      style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700)
                    ),
                  ),
                  const Text('₫', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(width: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 1.0),
                    child: Text(
                      currencyFormat.format(courseInfo?.price ?? 0.0), 
                      style: const TextStyle(fontSize: 14.0, color: Colors.black, decoration: TextDecoration.lineThrough)
                    ),
                  ),
                  const Text('₫', style: TextStyle(fontSize: 12.0,  color: Colors.black, decoration: TextDecoration.lineThrough)),
                ],
              ),
            ],
          ),
          ButtonRegisterCourse(courseInfo: courseInfo, type: 'bottom', courseType: courseType)
        ],
      ),
    );
  }
}