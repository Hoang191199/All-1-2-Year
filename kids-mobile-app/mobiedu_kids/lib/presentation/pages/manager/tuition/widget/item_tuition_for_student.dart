import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/data_tuition_detail.dart';

class ItemTuitionForStudent extends StatelessWidget {
  ItemTuitionForStudent({
    super.key,
    this.tuition_detail,
    this.index
  });

  final DataTuitionDetail? tuition_detail;
  final int? index;

  final currencyFormat = getCurrencyFormatVN();

  @override
  Widget build(BuildContext context) {
    int unit_price = int.parse(tuition_detail?.unit_price ?? '0');
    int unit_price_deduction = int.parse(tuition_detail?.unit_price_deduction ?? '0');

    return Container(
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
            '${index! + 1}.',
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
                    Expanded(
                      child: Text(
                        tuition_detail?.fee_name == null ? tuition_detail?.service_name ?? '' : tuition_detail?.fee_name ?? '',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${currencyFormat.format(unit_price)}đ',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                tuition_detail?.quantity_deduction == "0" && tuition_detail?.unit_price_deduction !="0" ?
                Text(
                  '${tuition_detail?.quantity} x ${currencyFormat.format(unit_price_deduction)}',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
                : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
