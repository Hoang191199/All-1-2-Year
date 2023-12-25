import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';

class TableTuitionForStudent extends StatelessWidget {
  TableTuitionForStudent({
    super.key,
    this.data
  });

  final TuitionItems? data;
  final currencyFormat = getCurrencyFormatVN();

  @override
  Widget build(BuildContext context) {
    int totalAmount = int.parse(data?.total_amount ?? '0');
    int debtAmount = int.parse(data?.debt_amount ?? '0');
    int paidAmount = int.parse(data?.paid_amount ?? '0');

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1, 
            color: AppColors.lightGrey
          )
        )
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(
            width: 1, 
            color: AppColors.lightGrey
          )
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Tổng tháng này',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  currencyFormat.format(totalAmount),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
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
                  'Nợ tháng trước',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  currencyFormat.format(debtAmount),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
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
                  'Tổng thanh toán',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  currencyFormat.format(paidAmount),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
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
                  'Còn nợ',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  data?.status == "0" ? currencyFormat.format(totalAmount) : "0",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
