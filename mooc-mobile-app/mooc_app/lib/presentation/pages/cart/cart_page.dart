import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_text_styles.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_binding.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/coupon_code/coupon_code_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_binding.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_binding.dart';
import 'package:mooc_app/presentation/pages/course_detail/course_detail_page.dart';
import 'package:mooc_app/presentation/pages/register_course/register_course_page.dart';

class CartPage extends StatelessWidget {
  CartPage({
    super.key,
    required this.courseTitle,
    required this.slug,
    required this.id,
  });

  final String courseTitle;
  final String slug;
  final int id;

  final currencyFormat = getCurrencyFormatVN();
  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController());
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return WillPopScope(
      onWillPop: onWillPop,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Giỏ hàng'),
        ),
        child: Container(
          padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height), bottom: bottomPadding),
          child: Obx(
            () => cartController.listCart.isEmpty
              ? const Center(
                child: Text('Bạn chưa thêm khóa học nào!', style: TextStyle(color: Colors.black54)),
              )
              : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        itemCount: cartController.numCoursesInCart,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(color: Colors.black12),
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    cartController.listCourseInCart[index]?.image_url?.isNotEmpty ?? false
                                      ? CachedNetworkImage(
                                        imageUrl: cartController.listCourseInCart[index]?.image_url ?? '',
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
                                          Text(
                                            cartController.listCourseInCart[index]?.title ?? '', 
                                            style: const TextStyle(fontSize: 12.0, color: Colors.black)
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            cartController.listCourseInCart[index]?.owner?.name ?? '', 
                                            style: const TextStyle(fontSize: 12.0, color: Colors.black45)
                                          ),
                                          const SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Text(
                                                '${currencyFormat.format(cartController.listCourseInCart[index]?.sale_price)}đ', 
                                                style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.red)
                                              ),
                                              const SizedBox(width: 6.0),
                                              Text(
                                                '${currencyFormat.format(cartController.listCourseInCart[index]?.price)}đ', 
                                                style: const TextStyle(fontSize: 12.0, color: Colors.black45, decoration: TextDecoration.lineThrough)
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handlePressDeleteCart(context, cartController.listCourseInCart[index]!);
                                },
                                child: const Icon(CupertinoIcons.delete, color: Colors.red),
                              )
                            ],
                          )
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              const Text('Tổng tiền:', style: TextStyle(fontSize: 13.0, color: Colors.black)),
                              const SizedBox(width: 10.0),
                              Text(
                                '${currencyFormat.format(getTotal("salePrice"))}đ', 
                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red)
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                '${currencyFormat.format(getTotal("price"))}đ', 
                                style: const TextStyle(fontSize: 13.0, color: Colors.black45, decoration: TextDecoration.lineThrough)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          width: widthScreen,
                          child: ElevatedButton(
                            onPressed: () {
                              handlePressRegister();
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
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text('Đặt hàng'.toUpperCase())
                            )
                          ),
                        )
                      ],
                    )
                  )
                ],
              )
          )
        )
      ),
    );
  }

  Future<bool> onWillPop() async {
    CourseDetailBinding().dependencies();
    CartBinding().dependencies();
    AddFreeCourseBinding().dependencies();
    CourseReviewBinding().dependencies();
    return await Get.off(() => CourseDetailPage(courseTitle: courseTitle, slug: slug, id: id)) ?? false;
  }
  
  double getTotal(String priceType) {
    double total = 0;
    var length = cartController.numCoursesInCart;
    for (var i = 0; i < length; i++) {
      if (priceType == 'salePrice') {
        total += (cartController.listCourseInCart[i]?.sale_price ?? 0.0);
      } else {
        total += (cartController.listCourseInCart[i]?.price ?? 0.0);
      }
    }
    return total;
  }
  
  void handlePressDeleteCart(BuildContext context, Course courseCart) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Thông báo', style: TextStyle(color: Colors.black)),
            content: const Text('Bạn chắc chắn muốn xóa khóa học này?', style: TextStyle(color: Colors.black)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy bỏ', style: TextStyle(color: Colors.black)),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  handlePressSubmitDelete(context, courseCart);
                },
                child: const Text('Đồng ý', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        }
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Thông báo', style: AppTextStyles.titleDialog),
          content: Text('Bạn chắc chắn muốn xóa khóa học này?', style: AppTextStyles.contentDialog),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy bỏ', style: AppTextStyles.actionCancelDialog),
            ),
            TextButton(
              onPressed: () {
                handlePressSubmitDelete(context, courseCart);
              },
              child: Text('Đồng ý', style: AppTextStyles.actionOKDialog),
            ),
          ],
        )
      );
    }
  }

  void handlePressSubmitDelete(BuildContext context, Course courseCart) {
    cartController.deleteCourseInCart(courseCart);
    Navigator.of(context).pop();
  }

  void handlePressRegister() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (authController.isLoggedIn.value) {
      List<Course> listCourseCart = [];
      for (var element in cartController.listCourseInCart) {
        listCourseCart.add(element!);
      }
      CouponCodeBinding().dependencies();
      Get.to(() => RegisterCoursePage(listCourseCart: listCourseCart));
    } else {
      await loginController.authenticate();
    }
  }
  
}