import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_detail_binding.dart';
import 'package:qltv/presentation/pages/borrow/borrow_detail.dart';

class ItemDocument extends StatelessWidget {
  const ItemDocument({super.key, this.item, this.widthItem, this.heightItem});

  final Borrow? item;
  final double? widthItem;
  final double? heightItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BorrowDetailBinding().dependencies();
        Get.to(() => BorrowDetail(id: item?.id ?? 0, type: 'detail'));
      },
      child: Container(
          width: widthItem ?? 160.0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    height: heightItem! / 28,
                    child: Center(
                      child: SvgPicture.asset(
                        showImage(item?.status ?? 0),
                        width: 22,
                      ),
                    )),
              ),
              Expanded(
                flex: 8,
                child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item?.title ?? "",
                            style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),
                        Text(
                            '${'status-request'.tr}: ${checkStatus(item?.status ?? 0)}',
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(height: 30),
                        Text(
                            '${'created-date'.tr}: ${formatDate(item?.created_at ?? '')}',
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    color: Color(0xFF7B858B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400))),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}

String showImage(int status) {
  switch (status) {
    case -1:
      return 'assets/svg/edit3.svg';
    case 0:
      return 'assets/svg/edit2.svg';
    case 1:
      return 'assets/svg/edit1.svg';
    default:
      return '';
  }
}

String formatDate(String date) {
  String dateString = date;
  late DateTime parsedDate;
  parsedDate = DateTime.parse(dateString);
  String formattedDate = DateFormat('d/M/y').format(parsedDate);

  return formattedDate;
}
