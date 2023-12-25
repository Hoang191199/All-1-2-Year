import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qltv/domain/entities/noti_data.dart';

class MessageNotification extends StatelessWidget {
  const MessageNotification(
      {super.key, this.widthItem, this.contentItem, required this.index});

  final double? widthItem;
  final NotiData? contentItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Get.to(() => NotificationDetails(
          //     widthItem: widthItem, contentItem: contentItem, index: index));
        },
        child: Container(
            // color: Colors.white,
            width: widthItem ?? 160.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black26),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(children: [
              Column(children: [
                Container(
                    width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child:
                        (contentItem?.title != null && contentItem?.title != '')
                            ? Text("${contentItem?.title}",
                                style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)
                            : Text(
                                "noti-title-empty".tr,
                                style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                // Container(
                //     width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                //     margin: const EdgeInsets.only(top: 12.0),
                //     padding: const EdgeInsets.only(left: 10.0),
                //     child: (contentItem?.content != null &&
                //             contentItem?.content != "")
                //         ? Html(
                //             data: "${contentItem?.content}",
                //             style: {
                //               "body": Style(fontSize: FontSize(17)),
                //             },
                //           )
                //         // style: GoogleFonts.kantumruy(
                //         //   textStyle: const TextStyle(fontSize: 17.0),
                //         // ),
                //         // maxLines: 5,
                //         // overflow: TextOverflow.ellipsis)
                //         : Text("noti-content-empty".tr,
                //             style: GoogleFonts.kantumruy(
                //               textStyle: const TextStyle(fontSize: 17.0),
                //             ),
                //             maxLines: 3,
                //             overflow: TextOverflow.ellipsis)),
                Container(
                    width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                    margin: const EdgeInsets.only(top: 12.0),
                    padding: const EdgeInsets.only(left: 10.0),
                    child: (contentItem?.description != null &&
                            contentItem?.description != "")
                        ? Text(
                            "${contentItem?.description}"
                                .replaceAll("", "\u{200B}"),
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(fontSize: 17.0)),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis)
                        // maxLines: 5,
                        // overflow: TextOverflow.ellipsis)
                        : const SizedBox()
                    // Text("noti-description-empty".tr,
                    //     style: GoogleFonts.kantumruy(
                    //       textStyle: const TextStyle(fontSize: 17.0),
                    //     ),
                    //     maxLines: 3,
                    //     overflow: TextOverflow.ellipsis)
                    ),
                // Container(
                //   width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                //   margin: const EdgeInsets.only(top: 12.0),
                //   padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       // Container(
                //       //     margin: const EdgeInsets.only(right: 1.0),
                //       //     child: Text(
                //       //       ("Lúc ${DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:sssZ').parse(contentItem?.created_at ?? "1900-01-01T00:00:000Z")), true).toLocal())}"),
                //       //       style: GoogleFonts.kantumruy(
                //       //         textStyle: const TextStyle(
                //       //             fontSize: 16.0, fontWeight: FontWeight.w600),
                //       //       ),
                //       //     )),
                //       // Row(
                //       //   children: const [
                //       //     Text('₫', style: TextStyle(fontSize: 12.0)),
                //       //   ],
                //       // )
                //       // Row(
                //       //   children: [
                //       //     Container(
                //       //       margin: const EdgeInsets.only(right: 1.0),
                //       //       child: Text("${courseItem?.slug ?? ""}",
                //       //           style: TextStyle(
                //       //               fontSize: 12.0,
                //       //               color: Colors.black45,
                //       //               decoration: TextDecoration.lineThrough)),
                //       //     ),
                //       //     Row(
                //       //       children: const [
                //       //         Text('₫',
                //       //             style: TextStyle(
                //       //                 fontSize: 10.0,
                //       //                 color: Colors.black45,
                //       //                 decoration: TextDecoration.lineThrough)),
                //       //       ],
                //       //     )
                //       //   ],
                //       // ),
                //     ],
                //   ),
                // )
              ]),
            ])));
  }
}
