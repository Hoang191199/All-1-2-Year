import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/history/order_history_controller.dart';

class HistoryPage extends GetView<AuthController> {
  // static String routeName = "/favorite";

  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    final order = Get.find<OrderHistoryController>();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Lịch sử giao dịch'),
        ),
        child: Obx(
          () => order.isLoading.value == false
              ? (order.data.value?.length != null &&
                      order.data.value!.isNotEmpty)
                  ? Container(
                      // padding: EdgeInsets.only(top: statusBarHeight),
                      child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemCount: order.data.value!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            // margin: EdgeInsets.all(20),
                            onTap: () {},
                            child: CupertinoButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // const Padding(
                                        //   padding: EdgeInsets.only(right: 12),
                                        //   child: SizedBox(
                                        //     height: 50,
                                        //     width: 50,
                                        //     child: CircleAvatar(
                                        //       child: Text("A"),
                                        //     ),
                                        //   ),
                                        // ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Row(children: [
                                                Container(
                                                    child: const Text(
                                                  "Tên : ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color(0xFF212121)),
                                                )),
                                                Container(
                                                    width: widthScreen * 4 / 6,
                                                    child: Text(
                                                      "${order.data.value?[index].courseNames}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xFF212121)),
                                                    )),
                                              ]),
                                              Row(children: [
                                                Container(
                                                    child: const Text(
                                                  "Phí: ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color(0xFF9E9E9E)),
                                                )),
                                                Container(
                                                    width: widthScreen / 2,
                                                    child: Row(children: [
                                                      Text(
                                                        "${order.data.value?[index].paymentFee}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF9E9E9E)),
                                                      ),
                                                      const Text(
                                                        "/",
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: Color(
                                                                0xFF9E9E9E)),
                                                      ),
                                                      Text(
                                                        "${order.data.value?[index].totalAmount}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF9E9E9E),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      )
                                                    ]))
                                              ]),
                                              Row(children: [
                                                Container(
                                                    child: const Text(
                                                  "Ngày giao dịch : ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color(0xFF212121)),
                                                )),
                                                Container(
                                                    width: widthScreen / 2,
                                                    child: Text(
                                                      "${order.data.value?[index].createdDate}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xFF212121)),
                                                    )),
                                              ]),
                                            ]))
                                      ],
                                    ),
                                    const Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 0.5,
                        );
                      },
                    ) // Container(
                      //   padding: EdgeInsets.only(top: 300),
                      //   alignment: Alignment.center,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         'assets/images/logo.png',
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      )
                  : Container(
                      child: const Center(
                        child: Text("Không có giao dịch nào"),
                      ),
                    )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ));
  }
}
