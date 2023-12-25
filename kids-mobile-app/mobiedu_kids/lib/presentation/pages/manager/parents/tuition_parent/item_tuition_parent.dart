import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/tuition_parent/history_using.dart';

class ItemTuitionParent extends StatelessWidget {
  ItemTuitionParent({
    super.key,
    required this.index
  });

  final currencyFormat = getCurrencyFormatVN();
  final int index;
  final tuitionsParentController = Get.find<TuitionsParentController>();
  
  @override
  Widget build(BuildContext context) {
    String dateString = tuitionsParentController.responseTuitions.value?.data?.tuitions?[index].month ?? '06/2023';
    List<String> dateComponents = dateString.split('-');
    int totalAmount = int.parse(tuitionsParentController.responseTuitions.value?.data?.tuitions?[index].total_amount ?? '0');
    int paidAmount = int.parse(tuitionsParentController.responseTuitions.value?.data?.tuitions?[index].paid_amount ?? '0');
    int id = int.parse(tuitionsParentController.responseTuitions.value?.data?.tuitions?[index].tuition_child_id ?? '0');
    String monthYear = ('${dateComponents[1]}/${dateComponents[0]}');
    return GestureDetector(
      onTap: () async {
        Get.to(() => HistoryUsing(
          id: id,
          monthYear: monthYear,
          )
        );
      },
      child: Container(
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
                          dateComponents[0],
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
                          'Tháng ${dateComponents[1]}' ,
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
                    'Đã thanh toán: ${currencyFormat.format(paidAmount)}đ',
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
