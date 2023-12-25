import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/node_controller.dart';
import 'package:mooc_app/presentation/controllers/profile/fetch_profile_controller.dart';

class LoginDetails extends StatelessWidget {
  LoginDetails(
      {super.key,
      required this.fullname,
      this.code,
      required this.email,
      required this.phone,
      required this.action,
      required this.actionGroup,
      required this.content,
      required this.createdAt,
      required this.ip,
      required this.agent});
  String fullname;
  String? code;
  String email;
  String phone;
  String action;
  String actionGroup;
  String content;
  String createdAt;
  String ip;
  String agent;
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final node = Get.put(NodeController());

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Lịch sử đăng nhập'),
            ),
            child:
                // Obx(() =>
                Padding(
                    padding: EdgeInsets.only(
                        top: const CupertinoNavigationBar()
                                .preferredSize
                                .height +
                            statusBarHeight +
                            10),
                    child: Column(children: [
                      Container(
                          height: heightScreen -
                              const CupertinoNavigationBar()
                                  .preferredSize
                                  .height -
                              statusBarHeight -
                              100,
                          child: ListView(
                              padding: const EdgeInsets.only(top: 5),
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Container(
                                  child: const Center(
                                      child: Text("THÔNG TIN ĐĂNG NHẬP")),
                                ),
                                Column(children: [
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.user,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Họ và tên",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          fullname,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.message,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          email,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.phone,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "SĐT",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          phone,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.idBadge,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "IP Address",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          ip,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.calendar,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Date of access",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          createdAt,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.code,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Code",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          code == null ? "" : '${code!}',
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.gear,
                                                  color: Colors.black,
                                                ))),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Device agent",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          agent,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  CupertinoButton(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                FontAwesomeIcons.running,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Action",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          content,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 17),
                                        ))
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ]),
                                // Container(
                                //   height: double.infinity,
                                // ),
                                // Expanded(
                                //     child: GestureDetector(
                                //         onTap: () => {},
                                //         child: Row(
                                //           children: [
                                //             Expanded(
                                //                 child: Container(
                                //                     color: Colors.blue,
                                //                     child: Center(
                                //                         child: Text("Cập nhật tài khoản",
                                //                             textAlign: TextAlign.center,
                                //                             style: TextStyle(
                                //                               color: Colors.white,
                                //                               fontWeight: FontWeight.w700,
                                //                             )))))
                                //           ],
                                //         )))
                              ]))
                    ]))));
  }
}

// void _showDialog(BuildContext context, Widget child) {
//   showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => Container(
//             height: 216,
//             padding: const EdgeInsets.only(top: 6.0),
//             // The Bottom margin is provided to align the popup above the system navigation bar.
//             margin: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             // Provide a background color for the popup.
//             color: CupertinoColors.systemBackground.resolveFrom(context),
//             // Use a SafeArea widget to avoid system overlaps.
//             child: SafeArea(
//               top: false,
//               child: child,
//             ),
//           ));
// }
