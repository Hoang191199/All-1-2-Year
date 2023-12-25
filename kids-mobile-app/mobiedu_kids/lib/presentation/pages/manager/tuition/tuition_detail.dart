import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/item_tuition_detail.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class TuitionDetail extends StatelessWidget {
  TuitionDetail({
    super.key, 
    required this.id,
    this.month
    });

  final int id;
  final String? month;
  final tuitionsController = Get.find<TuitionsController>();
  
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return GetX(
      init: tuitionsController,
      initState: (state) {
        tuitionsController.tuitionsDetail(id);
      },
      builder: (_) {
        return CupertinoPageScaffold(
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
              'Chi tiết',
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
          child: 
          tuitionsController.isLoadingDetail.value
          ? SizedBox(
              width: widthScreen,
              child: const Center(
                child: CircularLoadingIndicator(),
              ),
            )
          : tuitionsController.responseTuitionsDetail.value?.data?.tuition_child?.length != 0 ?
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ListView.builder(
                itemCount: tuitionsController.responseTuitionsDetail.value?.data?.tuition_child?.length,
                itemBuilder: (context, index) => ItemTuitionDetail(
                  item: tuitionsController.responseTuitionsDetail.value?.data?.tuition_child?[index],
                  index: index,
                  month: month,
                )
              )
            ) 
          : Text("xx")
        );
      }
    );
  }
}
