import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/prescription_add.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/prescription_info.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/widget/button_prescription.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class PrescriptionPage extends StatelessWidget {
  PrescriptionPage({super.key});
  
  final prescriptionController = Get.find<PrescriptionController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: prescriptionController,
      initState: (state) async {
        await prescriptionController.fetchData();
      },
      builder: (_) { 
      return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      }, 
      child:
      CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 19.0),
          leading: GestureDetector(
            onTap: () {
              Get.delete<PrescriptionController>();
              Navigator.pop(context);
            },
            child: Container(
              width: 70.0,
              color: Colors.transparent,
              child: Icon(
                CupertinoIcons.back,
                color: AppColors.primary,
              ),
            ),
          ),
          middle: Center(
            child:Text(
              'Đơn thuốc hôm nay',
              style: GoogleFonts.raleway( 
                textStyle: TextStyle(
                  color: AppColors.primary, 
                  fontSize: 22.0, 
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    PrescriptionBinding().dependencies();
                    prescriptionController.listChild();
                    _addPrescription(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: const BorderRadius.all(Radius.circular(4.0))
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          border: const Border(),
        ), 
        child: 
        prescriptionController.isLoading.value
        ? SizedBox(
            width: widthScreen,
            child: const Center(
              child: CircularLoadingIndicator(),
            ),
          )
        :
        prescriptionController.prescriptionData.isNotEmpty ?
        Container(
          margin: const EdgeInsetsDirectional.only(top: 36.0),
          child: 
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:() {
                            if(prescriptionController.stt.value == 0){
                              prescriptionController.stt.value = (prescriptionController.responsePrescription.value?.data?.medicines?.length ?? 0) -1;
                            }else{
                              prescriptionController.decreaseStt();
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              CupertinoIcons.left_chevron,
                              size: 30.0,
                              color: AppColors.primary,
                            ),
                          )
                        ),
                        const SizedBox(width: 20.0),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            child: prescriptionController.currentData?.child_picture == null ?
                            Image.asset(
                              'assets/images/avatar-mac-dinh.png',
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: urlImageNewPost(prescriptionController.currentData?.child_picture?? '') ,
                              progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                              errorWidget: (context, url, error) => const AvatarError(),
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        const SizedBox(width: 20.0),
                        GestureDetector(
                          onTap:() {
                            if((prescriptionController.stt.value +1 ) < (prescriptionController.responsePrescription.value?.data?.medicines?.length ?? 0)){
                              prescriptionController.incrementStt();
                            }else{
                              prescriptionController.stt.value = 0; 
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              CupertinoIcons.right_chevron,
                              size: 30.0,
                              color: AppColors.primary,
                            )
                          )
                        )
                      ],
                    ),
                    Text('${prescriptionController.stt.value + 1}. ${prescriptionController.currentData?.child_name}',
                      style: GoogleFonts.raleway( 
                        textStyle: TextStyle(
                          color: AppColors.primary, 
                          fontSize: 16.0, 
                          fontWeight: FontWeight.w700,
                          height: 2
                        ),
                      ),
                    ),
                    Text('${prescriptionController.currentData?.birthday}',
                      style: GoogleFonts.raleway( 
                        textStyle: TextStyle(
                          color: AppColors.grey, 
                          fontSize: 14.0, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40.0),
                Expanded(
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(top: 36.0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: widthScreen,
                                padding: const EdgeInsets.only(top: 48.0),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(61.0),
                                    topRight: Radius.circular(61.0),
                                  ),
                                  color: Color(0xFFFFF4FA),
                                ),
                                child: PrescriptionInfo(
                                  end: prescriptionController.currentData?.end,
                                  medicine_list: prescriptionController.currentData?.medicine_list,
                                  guide: prescriptionController.currentData?.guide,
                                  image: prescriptionController.currentData?.source_file,
                                  details: prescriptionController.currentData?.details,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: bottomPadding,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    PrescriptionBinding().dependencies();
                                    _showDialog(
                                      context, 
                                      prescriptionController.currentData?.details == [] ? "delete" : "cancel", 
                                      int.parse(prescriptionController.currentData?.child_id ?? '0'), 
                                      int.parse(prescriptionController.currentData?.medicine_id ?? '0'),
                                      int.parse(prescriptionController.currentData?.time_per_day ?? '0')
                                    );
                                  },
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Hủy',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
                                    onPressed: () {
                                      PrescriptionBinding().dependencies();
                                      _showDialog(
                                        context,
                                        "medicate",
                                        int.parse(prescriptionController.currentData?.child_id ?? '0'), 
                                        int.parse(prescriptionController.currentData?.medicine_id ?? '0'),
                                        int.parse(prescriptionController.currentData?.time_per_day ?? '0')
                                      );
                                    },
                                    color: AppColors.pink,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Uống thuốc',
                                      style: GoogleFonts.raleway(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          : const NoData(),
          )
        );
      }
    );
  }
}

void _showDialog(BuildContext context, String? type, int child_id, int medicine_id, int? max) {
  double heightScreen = MediaQuery.of(context).size.height;

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) => Container(
      height: heightScreen / 4,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
        left: 28.0,
        right: 28.0
      ),
      // color: CupertinoColors.systemBackground.resolveFrom(context),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            type != "medicate" ? "Hủy đơn thuốc" : "Gửi thuốc",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ),
          Text(
            type != "medicate" ? "Bạn có muốn hủy đơn thuốc?" : "Cho học sinh uống thuốc?",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 33.0),
          ButtonPrescription(
             type: type ?? '',
             child_id: child_id,
             medicine_id: medicine_id,
             max: max,
          )
        ],
      )
    ),
  );
}

void _addPrescription(BuildContext context) {
  double heightScreen = MediaQuery.of(context).size.height;

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) => 
      SizedBox(
        height: heightScreen - 300.0,
        child:  GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body:  PrescriptionAdd(),
          )
        )
      )
  );
}
