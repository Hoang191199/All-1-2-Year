import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qltv/domain/entities/lend_details.dart';
import '../pages/account/option/history_details.dart';

class LendingHistory extends StatelessWidget {
  const LendingHistory(
      {super.key, this.widthItem, this.contentItem, required this.index});

  final double? widthItem;
  final LendDetails? contentItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => HistoryDetails(
              widthItem: widthItem, contentItem: contentItem, index: index));
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
                    child: Text("${"lend-times".tr} ${index + 1}",
                        style: GoogleFonts.kantumruy(
                          textStyle: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis)),
                Container(
                    width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                    margin: const EdgeInsets.only(top: 12.0),
                    padding: const EdgeInsets.only(left: 10.0),
                    child: contentItem?.receipt_date != null
                        ? Text(
                            "${"receipt-date".tr}: ${DateFormat('dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(contentItem?.receipt_date ?? "1900-01-01T00:00:00.000Z")), true).toLocal())}",
                            style: GoogleFonts.kantumruy(
                              textStyle: const TextStyle(fontSize: 17.0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        : Text("receipt-date-unknown".tr,
                            style: GoogleFonts.kantumruy(
                              textStyle: const TextStyle(fontSize: 17.0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                Container(
                    width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                    margin: const EdgeInsets.only(top: 12.0),
                    padding: const EdgeInsets.only(left: 10.0),
                    child: contentItem?.return_date != null
                        ? Text(
                            "${"return-date".tr}: ${DateFormat('dd-MM-yyyy').format(DateFormat('HH:mm:ss dd-MM-yyyy').parse(DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(contentItem?.return_date ?? "1900-01-01T00:00:00.000Z")), true).toLocal())}",
                            style: GoogleFonts.kantumruy(
                              textStyle: const TextStyle(fontSize: 17.0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        : Text("return-date-unknown".tr,
                            style: GoogleFonts.kantumruy(
                              textStyle: const TextStyle(fontSize: 17.0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                (contentItem?.is_punishment != null &&
                        contentItem?.forfeit != null &&
                        contentItem?.forfeit != 0)
                    ? Container(
                        width: widthItem != null ? widthItem! - 2 * 38 : 160.0,
                        margin: const EdgeInsets.only(top: 12.0),
                        padding: const EdgeInsets.only(left: 10.0),
                        child: (contentItem?.is_punishment != null &&
                                contentItem?.is_punishment != false)
                            ? Text(
                                "${"forfeit".tr}: ${NumberFormat("#,##0", "vi_VN").format(contentItem?.forfeit)} ${"currency".tr}",
                                style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(fontSize: 17.0),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                            : Text("forfeit-unknown".tr,
                                style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(fontSize: 17.0),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis))
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                )
              ]),
            ])));
  }
}
