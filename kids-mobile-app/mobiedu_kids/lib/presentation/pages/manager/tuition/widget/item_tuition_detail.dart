import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/data_tuition_childs.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/tuition_for_student.dart';

class ItemTuitionDetail extends StatelessWidget {
  ItemTuitionDetail({
    super.key, 
    this.item, 
    required this.index,
    this.month
  });

  final DataTuitionChilds? item;
  final int index;
  final String? month;
  
  final currencyFormat = getCurrencyFormatVN();
  final tuitionsController = Get.find<TuitionsController>();

  @override
  Widget build(BuildContext context) {
    int totalAmount = int.parse(item?.total_amount ?? '0');
    int tuition_child_id = int.parse(item?.tuition_child_id ?? '0');

    return GestureDetector(
      onTap: () {
        Get.to(() => TuitionForStudent(
          child_id: tuition_child_id, 
          index: index,
          name: item?.child_name ?? '',
          month: month,
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFD8D8D8),
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}.',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item?.child_name ?? '',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        item?.status == '0' ? 'Chưa thanh toán' : 'Đã thanh toán',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: item?.status == '0' ? AppColors.red : AppColors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '${currencyFormat.format(totalAmount)}đ',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
