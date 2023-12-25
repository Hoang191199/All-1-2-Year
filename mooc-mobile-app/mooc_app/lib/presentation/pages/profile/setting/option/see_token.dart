import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/services/local_storage.dart';

class SeeToken extends StatelessWidget {
  // static String routeName = "/favorite";

  const SeeToken({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Get.find<LocalStorageService>();
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Xem token"),
        ),
        child: Container(
          child: Column(children: [
            // Container(
            //   margin: EdgeInsets.only(
            //       top: CupertinoNavigationBar().preferredSize.height +
            //           statusBarHeight),
            //   child: Image.asset(
            //     'assets/images/sad.jpg',
            //     width: widthScreen / 2,
            //     height: heightScreen / 4,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthScreen / 20,
                  right: widthScreen / 20,
                  top: const CupertinoNavigationBar().preferredSize.height +
                      statusBarHeight),
              child: Column(children: [
                SelectableText(
                  token.notiTokenFromStorage,
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectableText(
                  token.tokenFromStorage,
                ),
              ]),
            ),
            // Container(
            //     margin: EdgeInsets.only(
            //         left: widthScreen / 20, right: widthScreen / 20),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: Size.fromHeight(40),
            //       ),
            //       child: FittedBox(
            //           child: Row(children: [
            //         Text(
            //           "Hủy",
            //           style: TextStyle(fontSize: 20, color: Colors.white),
            //         ),
            //       ])),
            //       onPressed: () {
            //         Get.back();
            //       },
            //     )),
            // Container(
            //     margin: EdgeInsets.only(
            //         left: widthScreen / 20, right: widthScreen / 20),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: Size.fromHeight(40),
            //         backgroundColor: Colors.white,
            //       ),
            //       child: FittedBox(
            //           child: Row(children: [
            //         Text(
            //           "Xóa tài khoản",
            //           style: TextStyle(fontSize: 20, color: Colors.grey),
            //         ),
            //       ])),
            //       onPressed: () {},
            //     ))
          ]),
        ));
  }
}
