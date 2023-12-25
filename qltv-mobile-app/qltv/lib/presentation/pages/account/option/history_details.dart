import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/domain/entities/lend_details.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails(
      {super.key, this.widthItem, this.contentItem, required this.index});
  final double? widthItem;
  final LendDetails? contentItem;
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
                              "history-details".tr,
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
                      margin: const EdgeInsets.only(bottom: 20.0, left: 28),
                      child: Row(
                        children: [
                          Text(
                            "${"lend-times".tr} ${index + 1}",
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
                      margin: const EdgeInsets.only(bottom: 20.0, left: 28),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              width: widthScreen * 5 / 6,
                              child: Text(
                                "lending-info".tr,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.kantumruy(
                                    textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        contentItem?.receipt_date != null
                            ? Row(
                                children: [
                                  Container(
                                    width: widthScreen * 5 / 6,
                                    child: Text(
                                      "${"receipt-date".tr}: ${DateFormat('dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(contentItem?.receipt_date ?? "1900-01-01T00:00:00.000Z")), true).toLocal())}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                      )),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    width: widthScreen * 5 / 6,
                                    child: Text(
                                      "${"receipt-date".tr}: ${"unknown".tr}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                        contentItem?.return_date != null
                            ? Row(
                                children: [
                                  Container(
                                    width: widthScreen * 5 / 6,
                                    child: Text(
                                      "${"return-date".tr}: ${DateFormat('dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(contentItem?.return_date ?? "1900-01-01T00:00:00.000Z")), true).toLocal())}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                      )),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    width: widthScreen * 5 / 6,
                                    child: Text(
                                      "${"return-date".tr}: ${"unknown".tr}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                        contentItem?.real_return_date != null
                            ? Row(
                                children: [
                                  Container(
                                    width: widthScreen * 5 / 6,
                                    child: Text(
                                      "${"real-return-date".tr}: ${DateFormat('dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(contentItem?.real_return_date ?? "1900-01-01T00:00:00.000Z")), true).toLocal())}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                      )),
                                    ),
                                  )
                                ],
                              )
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
                    contentItem?.is_punishment != null &&
                            contentItem?.is_punishment != false
                        ? Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, left: 28),
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    "punishment-info".tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              contentItem?.punishment_reason != null
                                  ? Row(
                                      children: [
                                        Container(
                                          width: widthScreen * 5 / 6,
                                          child: Text(
                                            "${"punishment-reason".tr}: ${contentItem?.punishment_reason}"
                                                .replaceAll("", "\u{200B}"),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black,
                                            )),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "${"punishment-reason".tr}: ${"unknown".tr}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black,
                                          )),
                                        ),
                                      ],
                                    ),
                              contentItem?.forfeit != null
                                  ? Row(
                                      children: [
                                        Text(
                                          "${"forfeit".tr}: ${NumberFormat("#,##0", "vi_VN").format(contentItem?.forfeit)} ${"currency".tr}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black,
                                          )),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "${"forfeit".tr}: ${"unknown".tr}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black,
                                          )),
                                        ),
                                      ],
                                    ),
                            ]),
                          )
                        : const SizedBox(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 28),
                      child: Column(children: [
                        Row(
                          children: [
                            Text(
                              "publications-info".tr,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        Container(
                          width: widthScreen,
                          child: Text(
                            "${"title".tr}: ${contentItem?.title}",
                            // .replaceAll("", "\u{200B}"),
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                            )),
                          ),
                        ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Text(
                              "${"code".tr}: ${contentItem?.code}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${"identification-number".tr}: ${contentItem?.identification_number}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              )),
                            ),
                          ],
                        ),
                      ]),
                    )
                  ]),
                ))));
  }
}
