
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/checkout_courses/checkout_courses_binding.dart';
import 'package:mooc_app/presentation/controllers/coupon_code/coupon_code_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/register_course_controller.dart';
import 'package:mooc_app/presentation/pages/register_course/payment_page.dart';
import 'package:mooc_app/presentation/pages/register_course/widgets/register_form_input_item.dart';

class RegisterCoursePage extends StatelessWidget {
  RegisterCoursePage({
    super.key,
    this.listCourseCart,
  });

  final List<Course>? listCourseCart;

  final currencyFormat = getCurrencyFormatVN();
  final couponCodeInputController = TextEditingController();

  final couponCodeController = Get.find<CouponCodeController>();
  final registerCourseController = Get.put(RegisterCourseController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Xác nhận thông tin'),
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height), 
                left: 10.0, 
                right: 10.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Thông tin cá nhân'.toUpperCase(), 
                      style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black)
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        RegisterFormInputItem(
                          label: 'Họ và tên',
                          code: 'fullname',
                          inputController: registerCourseController.fullnameInputController
                        ),
                        RegisterFormInputItem(
                          label: 'Email',
                          code: 'email',
                          inputController: registerCourseController.emailInputController
                        ),
                        RegisterFormInputItem(
                          label: 'Số điện thoại',
                          code: 'phone',
                          inputController: registerCourseController.phoneInputController
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      itemCount: listCourseCart?.length ?? 0,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(height: 20.0),
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            listCourseCart?[index].image_url?.isNotEmpty ?? false
                              ? CachedNetworkImage(
                                imageUrl: listCourseCart?[index].image_url ?? '',
                                width: 100.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ) 
                              : Image.asset(
                                'assets/images/banner_home_1.png',
                                width: 100.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listCourseCart?[index].title ?? '', style: const TextStyle(fontSize: 12.0, color: Colors.black)),
                                  const SizedBox(height: 10.0),
                                  Text(listCourseCart?[index].owner?.name ?? '', style: const TextStyle(fontSize: 12.0, color: Colors.black45)),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    '${currencyFormat.format(listCourseCart?[index].sale_price)}đ', 
                                    style: const TextStyle(fontSize: 12.0, color: Colors.black45)
                                  ),
                                ],
                              )
                            )
                          ],
                        )
                      )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Áp dụng mã khuyến mại", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black)),
                        const SizedBox(height: 8.0),
                        const Text("Mã khuyến mại được nhận từ các sự kiện của hệ thống", style: TextStyle(fontSize: 12.0, color: Colors.black)),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widthScreen - 20.0 - 20.0 - 10.0 - 100.0,
                                child: TextField(
                                  controller: couponCodeInputController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    ),
                                    hintText: 'Nhập mã khuyến mại',
                                    hintStyle: TextStyle(color: Colors.black38),
                                    contentPadding: EdgeInsets.all(10.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 100.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    handlePressCheckCouponCode(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: AppColors.primaryBlue,
                                    disabledBackgroundColor: Colors.white54,
                                    textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: const Text('Áp dụng')
                                  )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thanh toán'.toUpperCase(), 
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black)
                        ),
                        Obx(
                          () => couponCodeController.couponCodeData.value != null 
                            ? Column(
                              children: [
                                const SizedBox(height: 14.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Giá gốc', style: TextStyle(fontSize: 13.0, color: Colors.black)),
                                    Text(
                                      '${currencyFormat.format(couponCodeController.couponCodeData.value?.total_price)}đ', 
                                      style: const TextStyle(fontSize: 13.0, color: Colors.black)
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Giảm giá', style: TextStyle(fontSize: 13.0, color: Colors.black)),
                                    Text(
                                      '${currencyFormat.format(couponCodeController.couponCodeData.value?.discount)}đ', 
                                      style: const TextStyle(fontSize: 13.0, color: Colors.black)
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Container()
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tổng số tiền', style: TextStyle(fontSize: 13.0, color: Colors.black)),
                            Obx(
                              () => couponCodeController.couponCodeData.value != null
                                ? Text(
                                  '${currencyFormat.format(couponCodeController.couponCodeData.value?.price)}đ', 
                                  style: const TextStyle(fontSize: 13.0, color: Colors.black)
                                )
                                : Text(
                                  '${currencyFormat.format(getTotalSalePrice())}đ', 
                                  style: const TextStyle(fontSize: 13.0, color: Colors.black)
                                )
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                    width: widthScreen,
                    child: ElevatedButton(
                      onPressed: () {
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
                ],
              ),
            )
          )
        )
      )
    );
  }
  
  double getTotalSalePrice() {
    double totalSalePrice = 0;
    var length = listCourseCart?.length ?? 0;
    for (var i = 0; i < length; i++) {
      totalSalePrice += listCourseCart?[i].sale_price ?? 0;
    }
    return totalSalePrice;
  }

  void handlePressCheckCouponCode(BuildContext context) async {
    var couponCode = couponCodeInputController.text.trim();
    if (couponCode.isNotEmpty) {
      var paymentType = "";
      var address = "";
      var idPackage = 0;
      List<int> idCourses = [];
      for (var i = 0; i < (listCourseCart?.length ?? 0); i++) {
        idCourses.add(listCourseCart?[i].id ?? 0);
      }
      try {
        await couponCodeController.applyCouponCode(paymentType, address, idCourses, idPackage, couponCode);
        if (!(couponCodeController.responseData.value?.error ?? false)) {
          showSnackbar(SnackbarType.success, "Mã khuyến mại", "Áp dụng mã khuyến mại thành công");
        } else {
          if (couponCodeController.responseData.value?.code == ResponseCode.loginSession) {
            if (context.mounted) {
              showLoginSessionDialog(context);
            }
          } else if (couponCodeController.responseData.value?.code == ResponseCode.notFound) {
            showSnackbar(SnackbarType.notice, "Mã khuyến mại", couponCodeController.responseData.value?.message ?? "Mã khuyến mại không tồn tại hoặc đã bị xóa.");
          } else {
            showSnackbar(SnackbarType.error, "Mã khuyến mại", "Áp dụng mã khuyến mại không thành công");
          }
        }
      } catch (error) {
        couponCodeController.setLoadingComplete();
        showSnackbar(SnackbarType.error, "Error", "Có lỗi xảy ra, vui lòng thử lại");
      }
    }
  }
  
  void handlePressSubmit(BuildContext context) async {
    var fullname = registerCourseController.fullnameInputController.text.trim();
    var email = registerCourseController.emailInputController.text.trim();
    var phone = registerCourseController.phoneInputController.text.trim();
    var couponCode = couponCodeInputController.text.trim();
    var isOK = false;
    if (fullname.isEmpty) {
      isOK = false;
    } else if (email.isEmpty) {
      isOK = false;
    } else if (!isValidEmail(email)) {
      isOK = false;
    } else if (phone.isEmpty) {
      isOK = false;
    } else if (!isValidPhone(phone)) {
      isOK = false;
    } else {
      isOK = true;
    }
    if (isOK) {
      await Future.delayed(const Duration(milliseconds: 200));
      CheckoutCoursesBinding().dependencies();
      Get.to(() => PaymentPage(
        fullname: fullname,
        email: email,
        phone: phone,
        couponCode: couponCode,
        listCourseCart: listCourseCart,
      ));
    } else {
      if (context.mounted) {
        showAlertDialog(context, 'Thông báo', 'Vui lòng điền chính xác thông tin cá nhân!');
      }
    }
  }
}