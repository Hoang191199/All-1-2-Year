import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/data_tuitions.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/tuition_detail.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ItemTuition extends StatelessWidget {
  ItemTuition({
    super.key,
    this.tuition,
  });

  final DataTuitions? tuition;
  final tuitionsController = Get.find<TuitionsController>();
  final currencyFormat = getCurrencyFormatVN();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    String dateString = tuition?.month ?? '06/2023';
    DateTime date = DateFormat('MM/yyyy').parse(dateString);
    String month = DateFormat('MM').format(date);
    String year = DateFormat('yyyy').format(date);
    String monthYear = DateFormat('MM/yyyy').format(date);

    int totalAmount = int.parse(tuition?.total_amount ?? '0');
    int id = int.parse(tuition?.tuition_id ?? '0');

    return GestureDetector(
      onTap: () {
        Get.to(() => TuitionDetail(id: id, month: monthYear));
      },
      child: tuitionsController.isLoading.value
      ? SizedBox(
          width: widthScreen,
            child: const Center(
              child: CircularLoadingIndicator(),
            ),
          )
      : Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
            margin: const EdgeInsets.only(bottom: 4.0),
            decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFD8D8D8),
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(color: AppColors.primary),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(80),
                },
                defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          year,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          'Tháng $month' ,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                          'Tổng thanh toán:',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${currencyFormat.format(totalAmount)}đ',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 6.0),
                  Text(
                    '${tuition?.paid_count} /${tuition?.count_child} học sinh đã thanh toán',
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
