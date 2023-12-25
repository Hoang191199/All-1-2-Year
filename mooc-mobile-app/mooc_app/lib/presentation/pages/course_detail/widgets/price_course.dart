// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
// import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

// import '../../../../app/services/local_storage.dart';

class PriceCourse extends StatelessWidget {
  PriceCourse({
    super.key,
    required this.price,
    required this.sellPrice,
    required this.discount,
    required this.slug
  });

  final double price;
  final double sellPrice;
  final int discount;
  final String slug;
  // final store = Get.find<LocalStorageService>();
  // final authController = Get.find<AuthController>();
  final currencyFormat = getCurrencyFormatVN();

  @override
  Widget build(BuildContext context) {
    return 
    // Obx(
    //   () => authController.isLoggedIn.value 
    //     ? Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         getPriceWidget(),
    //         getDiscountWidget(),
    //         CupertinoButton( onPressed: () { store.favListToStore = slug; print("${slug} ${store.favListFromStorage.length}"); }, child:
    //         Container(
    //           padding: const EdgeInsets.all(10.0),
    //           decoration: BoxDecoration(
    //             color: Colors.grey[200],
    //             shape: BoxShape.circle,
    //           ),
    //           child:store.favListFromStorage.contains(slug) ? Icon(CupertinoIcons.heart_fill, size: 18.0, color: Colors.red,) : Icon(CupertinoIcons.heart_fill, size: 18.0, color: Colors.white,) ,
    //           )
    //         )
    //       ],
    //     )
    //     : Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         getPriceWidget(),
    //         getDiscountWidget(),
    //       ],
    //     )
    // );
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPriceWidget(),
        getDiscountWidget(),
      ],
    );
  }

  Widget getPriceWidget () {
    return Row(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 6.0, right: 1.0),
              child: Text(
                currencyFormat.format(sellPrice), 
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
                currencyFormat.format(price), 
                style: const TextStyle(fontSize: 14.0, color: Colors.black, decoration: TextDecoration.lineThrough)
              ),
            ),
            const Text('₫', style: TextStyle(fontSize: 12.0,  color: Colors.black, decoration: TextDecoration.lineThrough)),
          ],
        ),
      ],
    );
  }

  Widget getDiscountWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.orange[800],
        borderRadius: const BorderRadius.all(Radius.circular(5.0))
      ),
      child: Text(
        '-${currencyFormat.format(discount)}%', 
        style: const TextStyle(fontSize: 11.0, color: Colors.white, letterSpacing: 0.2)
      ),
    );
  }
}