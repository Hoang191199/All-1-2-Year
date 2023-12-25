import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/item_tuition_for_student.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/table_tuition_for_student.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class TuitionForStudent extends StatelessWidget {
  TuitionForStudent({
    super.key, 
    required this.child_id, 
    required this.index,
    required this.name,
    this.month
  });

  final int child_id;
  final int index;
  final String name;
  final String? month;

  final tuitionsController = Get.find<TuitionsController>();
  

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
      init: tuitionsController,
      initState: (state) {
        tuitionsController.tuitionsItem(child_id);
      },
      builder: (_) {
        return  CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back,
                  color: AppColors.primary
                ),
              ),
            ),
            middle: Text(
              '${index + 1}. $name',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: tuitionsController.isLoadingItem.value ? 
          SizedBox(
              width: widthScreen,
              child: const Center(
                child: CircularLoadingIndicator(),
              ),
            )
        : Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1, 
                        color: AppColors.lightGrey
                      )
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tháng: ${month}",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      Text(
                        tuitionsController.responseTuitionsItem.value?.data?.status == "0" ?"Chưa thanh toán" : "Đã thanh toán",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: tuitionsController.responseTuitionsItem.value?.data?.status == "0" ? AppColors.red : AppColors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ]
                  ),
                ),
                tuitionsController.responseTuitionsItem.value?.data?.tuition_detail?.length != 0 ?
                Flexible(
                  child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tuitionsController.responseTuitionsItem.value?.data?.tuition_detail?.length,
                  itemBuilder: (context, index) => ItemTuitionForStudent(
                    tuition_detail: tuitionsController.responseTuitionsItem.value?.data?.tuition_detail?[index],
                    index: index
                  ),
                  )
                )
                : const SizedBox(),
                TableTuitionForStudent(data: tuitionsController.responseTuitionsItem.value?.data)
              ],
            ),
          ),
        );
      }
    );
  }
}
