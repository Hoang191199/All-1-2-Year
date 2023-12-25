import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/app/config/app_text_styles.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/checkout_courses/checkout_courses_controller.dart';
import 'package:mooc_app/presentation/pages/register_course/payment_onepay_page.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({
    super.key,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.couponCode,
    this.listCourseCart,
  });

  final String fullname;
  final String email;
  final String phone;
  final String couponCode;
  final List<Course>? listCourseCart;

  final checkoutCoursesController = Get.find<CheckoutCoursesController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Đặt hàng'),
      ),
      backgroundColor: Colors.grey[200],
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    'Lựa chọn hình thức thanh toán'.toUpperCase(),
                    style: const TextStyle(fontSize: 15.0, color: Colors.black)
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: widthScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    paymentMethodItem(PaymentMethod.internetBanking),
                    paymentMethodItem(PaymentMethod.visa),
                    paymentMethodItem(PaymentMethod.qr),
                    paymentMethodItem(PaymentMethod.momo),
                  ],
                ),
              ),
              Obx(
                () => checkoutCoursesController.method.value.isEmpty 
                  ? Container()
                  : Container(
                    margin: const EdgeInsets.only(top: 60.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: widthScreen,
                    child: ElevatedButton(
                      onPressed: checkoutCoursesController.isLoading.value ? null : () {
                        handlePressSubmit(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))
                        ),
                        elevation: 0.0,
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.white54,
                        textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Tiếp tục'.toUpperCase())
                      )
                    ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentMethodItem(String paymentMethod) {
    return GestureDetector(
      onTap: () {
        handlePressMethod(paymentMethod);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Row(
          children: [
            Obx(
              () => checkoutCoursesController.method.toString() == paymentMethod.toString()
                ? const Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.green)
                : const Icon(CupertinoIcons.circle, color: Colors.black26),
            ),
            const SizedBox(width: 10.0),
            paymentMethodItemIcon(paymentMethod),
            const SizedBox(width: 14.0),
            paymentMethodItemContent(paymentMethod)
          ],
        ),
      ),
    );
  }

  Widget paymentMethodItemIcon(String paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethod.internetBanking:
        return Image.asset('assets/images/online-atm.png', width: 50.0, height: 50.0, fit: BoxFit.contain);
      case PaymentMethod.visa:
        return Image.asset('assets/images/online-master-visa.png', width: 50.0, height: 50.0, fit: BoxFit.contain);
      case PaymentMethod.qr:
        return Image.asset('assets/images/online-qr.png', width: 50.0, height: 50.0, fit: BoxFit.contain);
      case PaymentMethod.momo:
        return Image.asset('assets/images/momo.png', width: 50.0, height: 50.0, fit: BoxFit.contain);
      default:
        return Container();
    }
  }

  Widget paymentMethodItemContent(String paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethod.internetBanking:
        return Expanded(
          child: Text("Thanh toán bằng thẻ ATM, internet banking", style: AppTextStyles.paymentMethod)
        );
      case PaymentMethod.visa:
        return Expanded(
          child: Text("Thanh toán bằng thẻ quốc tế", style: AppTextStyles.paymentMethod)
        );
      case PaymentMethod.qr:
        return Expanded(
          child: Text("Thanh toán bằng mã QR", style: AppTextStyles.paymentMethod)
        );
      case PaymentMethod.momo:
        return Expanded(
          child: Text("Thanh toán bằng ví điện tử MOMO", style: AppTextStyles.paymentMethod)
        );
      default:
        return Container();
    }
  }
  
  void handlePressMethod(String type) {
    checkoutCoursesController.changeMethod(type);
  }

  void handlePressSubmit(BuildContext context) async {
    var paymentType = checkoutCoursesController.method.value;
    var address = "";
    var idPackage = 0;
    List<int> idCourses = [];

    if (listCourseCart?[0].idPackage == null || listCourseCart?[0].idPackage == 0) {
      for (var i = 0; i < (listCourseCart?.length ?? 0); i++) {
        idCourses.add(listCourseCart?[i].id ?? 0);
      }
    } else {
        idCourses = [];
        idPackage = listCourseCart?[0].idPackage ?? 0;
    }
    try {
      await checkoutCoursesController.checkoutCourses(fullname, phone, email, paymentType, address, idCourses, idPackage, couponCode);
      if (!(checkoutCoursesController.responseData.value?.error ?? false)) {
        var paymentURL = checkoutCoursesController.responseData.value?.data as String;
        if (paymentURL.isNotEmpty) {
          Get.to(() => PaymentOnepayPage(paymentURL: paymentURL, listCourseCart: listCourseCart));
        }
      } else {
        if (checkoutCoursesController.responseData.value?.code == ResponseCode.loginSession) {
          if (context.mounted) {
            showLoginSessionDialog(context);
          }
        } else {
          showSnackbar(SnackbarType.error, "Đặt hàng", checkoutCoursesController.responseData.value?.message ?? "Đặt hàng không thành công");
        }
      }
    } catch (error) {
      checkoutCoursesController.setLoadingComplete();
      showSnackbar(SnackbarType.error, "Error", "Có lỗi xảy ra, vui lòng thử lại");
    }
  }
}