import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/s3/s3_binding.dart';
import 'package:qltv/presentation/pages/account/account_page.dart';

class HomeUserInfo extends StatelessWidget {
  HomeUserInfo({super.key});

  final loginController = Get.find<LoginController>();
  final store = Get.find<LocalStorageService>();
  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<ProfileController>();
    double widthScreen = MediaQuery.of(context).size.width;
    Future<void> dialogSupport(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: (profile.reader.value?.userSite?.code != "" &&
                    profile.reader.value?.userSite?.code != null)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text("scan-guide".tr,
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ),
                      Container(
                        child: BarcodeWidget(
                          data: profile.reader.value?.userSite?.code ?? "",
                          barcode: Barcode.code128(),
                          width: widthScreen * 4 / 7,
                          drawText: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text("scan-guide-notfound".tr,
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ),
                      // Container(
                      //   child: BarcodeWidget(
                      //     data: profile.reader.value?.userSite?.code ?? "",
                      //     barcode: Barcode.code128(),
                      //     width: widthScreen * 4 / 7,
                      //   ),
                      // ),
                    ],
                  ),
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text('${'hello'.tr}${loginController.userLogin?.fullname}!',
                style: GoogleFonts.kantumruy(
                    textStyle: const TextStyle(
                        fontSize: 20.0,
                        height: 1.34,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)))),
        const SizedBox(width: 10.0),
        Container(
          width: 40.0,
          height: 40.0,
          child: IconButton(
              onPressed: () {
                dialogSupport(context);
              },
              icon: const Icon(
                CupertinoIcons.barcode_viewfinder,
                color: Colors.black,
              )),
        ),
        const SizedBox(width: 10.0),
        GestureDetector(
          child: Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: (profile.reader.value?.userSite?.metadata?.avatar_url
                            ?.isNotEmpty ??
                        false)
                    ? CachedNetworkImage(
                        imageUrl: profile
                                .reader.value?.userSite?.metadata?.avatar_url ??
                            '',
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const SizedBox(),
                        errorWidget: (context, url, error) =>
                            const Icon(CupertinoIcons.info),
                      )
                    : (store.userFromStorage?.avatar_url?.isNotEmpty ?? false)
                        ? CachedNetworkImage(
                            imageUrl: store.userFromStorage?.avatar_url ?? '',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const SizedBox(),
                            errorWidget: (context, url, error) =>
                                const Icon(CupertinoIcons.info),
                          )
                        : Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/anonymous.jpg'),
                                  fit: BoxFit.cover),
                              // borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(8.0),
                              //     topRight: Radius.circular(8.0)),
                            ),
                          ),
                // Container(
                //     width: 40.0,
                //     height: 40.0,
                //     decoration: BoxDecoration(
                //       color: HexColor('7B858B'),
                //     ),
                //   )
              )),
          onTap: () async {
            S3Binding().dependencies();
            Get.to(() =>
                    // CustomInitPage(
                    //       child:
                    AccountPage()
                //   ,widgetIndex: 0,
                // )
                );
            await profile.fetchProfile();
            bookcaseController.bookcaseFilterType.value = [1, 2];
            await bookcaseController.fetchData();
            bookcaseController.bookcaseFilterType.value = [0, 1, 2];
          },
        )
      ],
    );
  }
}
