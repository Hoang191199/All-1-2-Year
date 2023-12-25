import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccount extends StatelessWidget {
  // static String routeName = "/favorite";

  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Xóa tài khoản"),
        ),
        child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  top: CupertinoNavigationBar().preferredSize.height +
                      statusBarHeight),
              child: Image.asset(
                'assets/images/sad.jpg',
                width: widthScreen / 2,
                height: heightScreen / 4,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthScreen / 20, right: widthScreen / 20),
              child: Column(children: const [
                Text(
                  "Lưu ý : tài khoản sau khi xóa sẽ không thể phục hồi lại được",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  "Bạn sẽ mất tất cả thông tin và ưu đãi cá nhân bao gồm tất cả các khóa học",
                ),
                Text(
                  "Sau khi xóa tài khoản bạn sẽ không thể dùng lại email và số điện thoại của tài khoản này để tạo tài khoản mới luôn nha",
                ),
              ]),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: widthScreen / 20, right: widthScreen / 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: FittedBox(
                      child: Row(children: const [
                    Text(
                      "Hủy",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])),
                  onPressed: () {
                    Get.back();
                  },
                )),
            Container(
                margin: EdgeInsets.only(
                    left: widthScreen / 20, right: widthScreen / 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Colors.white,
                  ),
                  child: FittedBox(
                      child: Row(children: const [
                    Text(
                      "Xóa tài khoản",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ])),
                  onPressed: () {},
                ))
          ]),
        ));
  }
}
