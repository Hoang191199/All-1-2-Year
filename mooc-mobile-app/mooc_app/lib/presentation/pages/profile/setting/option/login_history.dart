import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/profile/setting/option/login_details.dart';

import '../../../../controllers/scroll_controller.dart';

class LoginHistoryPage extends StatelessWidget {
  LoginHistoryPage({super.key});
  int page = 0;
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final scroll = Get.put(ScrollingController(
        page: page,
        height: heightScreen -
            const CupertinoNavigationBar().preferredSize.height));
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Xem lịch sử đăng nhập"),
          // trailing: Obx(() => scroll.paging.value == null ? CircularProgressIndicator() :  (page < scroll.paging.value!.last_page) ? CupertinoButton(padding: EdgeInsets.zero,onPressed: () { Get.to(() => LoginHistoryPage(page: page + 1,)); }, child: Icon(CupertinoIcons.chevron_forward,size: 30,),) : CupertinoButton(padding: EdgeInsets.zero,onPressed: () {}, child: Icon(CupertinoIcons.chevron_forward,color: Colors.grey,size: 30,),),),
        ),
        child: Obx(() => (scroll.paging.value == null ||
                scroll.isInitialized.value == false)
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : (scroll.loginData.value.isNotEmpty)
                ? ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: scroll.scrollController2,
                    itemCount: scroll.loginData.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          // margin: EdgeInsets.all(20),
                          onTap: () {},
                          child: CupertinoButton(
                              onPressed: () {
                                Get.to(() => LoginDetails(
                                    fullname:
                                        scroll.loginData.value[index].fullname,
                                    code: scroll.loginData.value[index].code,
                                    email: scroll.loginData.value[index].email,
                                    phone: scroll.loginData.value[index].phone,
                                    action:
                                        scroll.loginData.value[index].action,
                                    actionGroup: scroll
                                        .loginData.value[index].actionGroup,
                                    content:
                                        scroll.loginData.value[index].content,
                                    createdAt:
                                        scroll.loginData.value[index].createdAt,
                                    ip: scroll.loginData.value[index].ip,
                                    agent:
                                        scroll.loginData.value[index].agent));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            child: Icon(CupertinoIcons
                                                .square_arrow_right),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Row(children: [
                                              Container(
                                                  child: const Text(
                                                "Time: ",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Color(0xFF212121)),
                                              )),
                                              Container(
                                                  width: widthScreen / 2,
                                                  child: Text(
                                                    // ignore: unnecessary_null_comparison
                                                    scroll.loginData.value !=
                                                            null
                                                        ? scroll
                                                            .loginData
                                                            .value[index]
                                                            .createdAt
                                                        : "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF212121)),
                                                  )),
                                            ]),
                                            Row(children: [
                                              Container(
                                                  child: const Text(
                                                "Device: ",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Color(0xFF9E9E9E)),
                                              )),
                                              Container(
                                                  width: widthScreen / 2,
                                                  child: Text(
                                                    // ignore: unnecessary_null_comparison
                                                    scroll.loginData.value !=
                                                            null
                                                        ? scroll.loginData
                                                            .value[index].agent
                                                        : "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF9E9E9E)),
                                                  ))
                                            ])
                                          ]))
                                    ],
                                  ),
                                  // const Icon(
                                  //   Icons.more_horiz,
                                  //   color: Colors.grey,
                                  // ),
                                ],
                              )));
                    })
                : Container(
                    child: const Center(
                    child: Text("Lịch sử trống"),
                  ))));
  }
}
