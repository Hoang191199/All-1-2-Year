import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/profile/roadmap/setting/roadmap_setting.dart';

import '../../../controllers/auth/auth_controller.dart';

class Roadmap extends GetView<AuthController> {
  // static String routeName = "/favorite";

  const Roadmap({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final auth = Get.find<AuthController>();
    // final road = Get.put();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Lộ trình học tập'),
        ),
        child: Container(
          // padding: EdgeInsets.only(top: statusBarHeight),
          child:
              // road ? Container(child: ListView(children: [],),) :
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                  // padding: EdgeInsets.only(top: 300),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/timetable.jpg',
                        width: widthScreen / 2,
                        height: heightScreen / 4,
                        fit: BoxFit.fill,
                      ),
                      const Text("Bạn chưa có lịch học nào ?"),
                      const Text(
                        "Nhận lời nhắc bằng cách sử dụng công cụ lập lịch học tập của bạn !",
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: widthScreen / 6, right: widthScreen / 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                            ),
                            child: FittedBox(
                                child: Row(children: const [
                              Text(
                                "Thêm lịch học tập",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: SizedBox(
                                    child: Icon(
                                  CupertinoIcons.add_circled_solid,
                                  color: Colors.white,
                                )),
                              ),
                            ])),
                            onPressed: () {
                              Get.to(() => RoadmapSetting(
                                    step: 1,
                                    title: ["Bước 1/3", "", ""],
                                  ));
                            },
                          ))
                    ],
                  ),
                ),
              ]),
        ));
  }
}
