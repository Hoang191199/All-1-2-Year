import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/domain/entities/noti_data.dart';

class NotificationDetails extends StatelessWidget {
  const NotificationDetails(
      {super.key, this.widthItem, this.contentItem, required this.index});
  final double? widthItem;
  final NotiData? contentItem;
  final int index;
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
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
            child: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Container(
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
                              "notification-details".tr,
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
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 28, right: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "notification-info".tr,
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 28, right: 28),
                      child: Column(children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "lending-info".tr,
                        //       style: GoogleFonts.kantumruy(
                        //           textStyle: const TextStyle(
                        //               fontSize: 17.0,
                        //               color: Colors.black,
                        //               fontWeight: FontWeight.bold)),
                        //     ),
                        //   ],
                        // ),
                        contentItem?.title != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${contentItem?.title}",
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    )),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${"receipt-date".tr}: ${"unknown".tr}",
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    )),
                                  ),
                                ],
                              ),
                        contentItem?.description != null
                            ? Text(
                                "${contentItem?.description}",
                                style: GoogleFonts.kantumruy(
                                    textStyle: const TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                )),
                              )
                            :
                            // Text(
                            //     "${"return-date".tr}: ${"unknown".tr}",
                            //     style: GoogleFonts.kantumruy(
                            //         textStyle: const TextStyle(
                            //       fontSize: 17.0,
                            //       color: Colors.black,
                            //     )),
                            //   )
                            const SizedBox(),
                        contentItem?.content != null
                            ? Html(
                                data: "${contentItem?.content}",
                                style: {"body": Style(fontSize: FontSize(20))},
                              )
                            // Text(
                            //   "${contentItem?.content}",
                            //   style: GoogleFonts.kantumruy(
                            //       textStyle: const TextStyle(
                            //     fontSize: 17.0,
                            //     color: Colors.black,
                            //   )),
                            // ),
                            : const SizedBox()
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "real-return-date".tr + ": " + "unknown".tr,
                        //       style: GoogleFonts.kantumruy(
                        //           textStyle: const TextStyle(
                        //             fontSize: 17.0,
                        //             color: Colors.black,
                        //           )),
                        //     ),
                        //   ],
                        // ),
                      ]),
                    ),
                    // contentItem?.is_punishment != null &&
                    //         contentItem?.is_punishment != false
                    //     ? Container(
                    //         margin:
                    //             const EdgeInsets.only(bottom: 20.0, left: 28),
                    //         child: Column(children: [
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 "punishment-info".tr,
                    //                 style: GoogleFonts.kantumruy(
                    //                     textStyle: const TextStyle(
                    //                         fontSize: 17.0,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.bold)),
                    //               ),
                    //             ],
                    //           ),
                    //           contentItem?.punishment_reason != null
                    //               ? Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       "${"punishment-reason".tr}: ${contentItem?.punishment_reason}",
                    //                       style: GoogleFonts.kantumruy(
                    //                           textStyle: const TextStyle(
                    //                         fontSize: 17.0,
                    //                         color: Colors.black,
                    //                       )),
                    //                     ),
                    //                   ],
                    //                 )
                    //               : Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       "${"punishment-reason".tr}: ${"unknown".tr}",
                    //                       style: GoogleFonts.kantumruy(
                    //                           textStyle: const TextStyle(
                    //                         fontSize: 17.0,
                    //                         color: Colors.black,
                    //                       )),
                    //                     ),
                    //                   ],
                    //                 ),
                    //           contentItem?.forfeit != null
                    //               ? Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       "${"forfeit".tr}: ${contentItem?.forfeit}",
                    //                       style: GoogleFonts.kantumruy(
                    //                           textStyle: const TextStyle(
                    //                         fontSize: 17.0,
                    //                         color: Colors.black,
                    //                       )),
                    //                     ),
                    //                   ],
                    //                 )
                    //               : Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       "${"forfeit".tr}: ${"unknown".tr}",
                    //                       style: GoogleFonts.kantumruy(
                    //                           textStyle: const TextStyle(
                    //                         fontSize: 17.0,
                    //                         color: Colors.black,
                    //                       )),
                    //                     ),
                    //                   ],
                    //                 ),
                    //         ]),
                    //       )
                    //     : const SizedBox(),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 20.0, left: 28),
                    //   child: Column(children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           "publications-info".tr,
                    //           style: GoogleFonts.kantumruy(
                    //               textStyle: const TextStyle(
                    //                   fontSize: 17.0,
                    //                   color: Colors.black,
                    //                   fontWeight: FontWeight.bold)),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           "${"title".tr}: ${contentItem?.title}",
                    //           style: GoogleFonts.kantumruy(
                    //               textStyle: const TextStyle(
                    //             fontSize: 17.0,
                    //             color: Colors.black,
                    //           )),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           "${"code".tr}: ${contentItem?.}",
                    //           style: GoogleFonts.kantumruy(
                    //               textStyle: const TextStyle(
                    //             fontSize: 17.0,
                    //             color: Colors.black,
                    //           )),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           "${"identification-number".tr}: ${contentItem?.identification_number}",
                    //           style: GoogleFonts.kantumruy(
                    //               textStyle: const TextStyle(
                    //             fontSize: 17.0,
                    //             color: Colors.black,
                    //           )),
                    //         ),
                    //       ],
                    //     ),
                    //   ]),
                    // )
                  ]),
                ))));
  }
}
