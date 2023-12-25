import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/splash/splash_page.dart';

class ConnectFailPage extends StatelessWidget {
  // static String routeName = "/favorite";

  const ConnectFailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
        // navigationBar: CupertinoNavigationBar(
        //   middle: Text("Không có kết nối mạng"),
        // ),
        child: Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(
              top: const CupertinoNavigationBar().preferredSize.height +
                  statusBarHeight),
          child: Image.asset(
            'assets/images/no_internet.jpg',
            width: widthScreen / 2,
            height: heightScreen / 4,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: widthScreen / 20, right: widthScreen / 20),
          child: Column(children: const [
            Text(
              "Thiết bị không có kết nối internet",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Hãy khôi phục kết nối mạng",
            ),
            Text(
              "Sử dụng mạng wifi hoặc dữ liệu di động",
            ),
          ]),
        ),
        Container(
            margin: EdgeInsets.only(
                left: widthScreen / 20, right: widthScreen / 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: FittedBox(
                  child: Row(children: const [
                Text(
                  "Thử lại",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ])),
              onPressed: () {
                Get.off(() => const SplashPage());
              },
            )),
      ]),
    ));
  }
}
