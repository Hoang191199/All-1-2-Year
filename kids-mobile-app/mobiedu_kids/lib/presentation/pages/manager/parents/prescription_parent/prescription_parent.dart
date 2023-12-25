import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
// import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/prescription_register.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/prescription_info.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class PrescriptionParent extends StatelessWidget {
  PrescriptionParent({
    super.key
  });

  final prescriptionChildController = Get.find<PrescriptionChildController>(); 
  final infoUser = Get.find<SplashScreenController>();
  final informationController = Get.find<InformationController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return GetX(
      init: prescriptionChildController,
      initState: (state) async {
        await prescriptionChildController.fetchData();
      },
      builder: (_) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 19.0),
            leading: GestureDetector(
              onTap: () {
                // final initPageTabController = Get.put(InitPageTabController());
                // initPageTabController.changeIndexTab(1);
                // Navigator.pop(context);
                Get.back();
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
                      _registerPrescription(context);
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
          child: prescriptionChildController.isLoading.value
        ? const SizedBox(
            child: Center(
              child: CircularLoadingIndicator(),
            ),
          )
        : prescriptionChildController.prescriptionData.isEmpty ?
          SizedBox(
            width: widthScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_assig.png'
                ),
                const SizedBox(height: 8.0),
                Text('Không có dữ liệu', 
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ]
            ),
          ):
          Container(
            margin: const EdgeInsetsDirectional.only(top: 36.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture == null ?
                    Image.asset(
                      'assets/images/avatar-mac-dinh.png',
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:  infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture ?? '',
                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                      errorWidget: (context, url, error) => const AvatarError(),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Text(infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_name ?? '',
                  style: GoogleFonts.raleway( 
                    textStyle: TextStyle(
                      color: AppColors.primary, 
                      fontSize: 16.0, 
                      fontWeight: FontWeight.w700,
                      height: 2
                    ),
                  ),
                ),
                Text(infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].birthday ?? '',
                  style: GoogleFonts.raleway( 
                    textStyle: TextStyle(
                      color: AppColors.grey, 
                      fontSize: 14.0, 
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: prescriptionChildController.responsePrescription.value?.data?.medicines?.length,
                    itemBuilder: (context, index){
                    return Container(
                      width: widthScreen,
                      padding: const EdgeInsets.only(top: 16.0),
                      color: AppColors.lightPink2,
                      child: Container(
                        width: widthScreen,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Text('Đợt ${index + 1}.',
                                style: GoogleFonts.raleway( 
                                  textStyle: TextStyle(
                                    color: AppColors.primary, 
                                    fontSize: 16.0, 
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              width: widthScreen,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.lightPink2
                                  )
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  'Ngày hết hạn: ${prescriptionChildController.responsePrescription.value?.data?.medicines?[index].end}',
                                  style: GoogleFonts.raleway( 
                                    textStyle: TextStyle(
                                      color: AppColors.black, 
                                      fontSize: 14.0, 
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              width: widthScreen,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.lightPink2
                                  )
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  'Thuốc: ${prescriptionChildController.responsePrescription.value?.data?.medicines?[index].medicine_list}',
                                  style: GoogleFonts.raleway( 
                                    textStyle: TextStyle(
                                      color: AppColors.black, 
                                      fontSize: 14.0, 
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              width: widthScreen,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.lightPink2
                                  )
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  'HDSD: ${prescriptionChildController.responsePrescription.value?.data?.medicines?[index].guide}',
                                  style: GoogleFonts.raleway( 
                                    textStyle: TextStyle(
                                      color: AppColors.black, 
                                      fontSize: 14.0, 
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            if(prescriptionChildController.responsePrescription.value?.data?.medicines?[index].details?.length != 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                  child: Text(
                                    'Lịch sử uống:',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: prescriptionChildController.responsePrescription.value?.data?.medicines?[index].details?.length,
                                  itemBuilder: (context, number) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                      child: Text(
                                        '${prescriptionChildController.responsePrescription.value?.data?.medicines?[index].details?[number].created_at} | ${prescriptionChildController.responsePrescription.value?.data?.medicines?[index].details?[number].user_fullname}',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    );
                                  } 
                                ),
                              ],
                            ),
                            const SizedBox(height: 14.0),
                            GestureDetector(
                              onTap: () {
                                showImage(context, prescriptionChildController.responsePrescription.value?.data?.medicines?[index].source_file, widthScreen, heightScreen);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Ảnh đơn thuốc',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    );
                  }),
                )
              ]
            ),
          )
        );
      }
    );
  }
}

void _registerPrescription(BuildContext context) {
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
            body:  PrescriptionRegister(),
          )
        )
      )
  );
}
