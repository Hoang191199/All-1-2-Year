import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/lending/lending_controller.dart';
import '../../../widgets/lending_history.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final lending = Get.find<LendingController>();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
        init: lending,
        initState: (state) async {
          await lending.fetchData();
        },
        didUpdateWidget: (old, newState) {},
        dispose: (state) {},
        builder: (context) {
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(top: statusBarHeight, bottom: 0),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(children: [
                        Container(
                          width: widthScreen / 6,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.chevron_left_rounded,
                                size: 40,
                                weight: 5,
                                color: Colors.grey,
                              )),
                        ),
                        Container(
                          width: widthScreen * 4 / 6,
                          child: Center(
                            child: Text(
                              "lending-history".tr,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 0),
                            child: lending.isLoading.value
                                ? Container(
                                    child: const Center(
                                    child: CircularProgressIndicator(),
                                  ))
                                : lending.responseData.isEmpty
                                    ? Center(
                                        child: Text("history-empty".tr,
                                            style: const TextStyle(
                                                color: Colors.black54)),
                                      )
                                    : ListView.separated(
                                        physics: const ClampingScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                            top: 10.0,
                                            left: 28.0,
                                            bottom: kBottomNavigationBarHeight +
                                                10.0,
                                            right: 28.0),
                                        itemCount: lending.responseData.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 10.0),
                                        itemBuilder: (context, index) {
                                          return LendingHistory(
                                            widthItem: widthScreen,
                                            contentItem:
                                                lending.responseData[index],
                                            index: index,
                                          );
                                        })))
                  ])));
        });
  }
}
