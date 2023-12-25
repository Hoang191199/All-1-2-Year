import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
// import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/prescription_parent.dart';

class PrescriptionInfo extends StatelessWidget {
  PrescriptionInfo({super.key});

  // final informationController = Get.find<InformationController>();
  final prescriptionChildController = Get.find<PrescriptionChildController>(); 

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
      // init: informationController,
      init: prescriptionChildController,
      initState: (state) {
        Get.put(ManagerController());
      },
      builder: (_) {
        return Container(
          width: widthScreen,
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Thuốc: ${informationController.responseInfomation.value?.data?.medicines?[0].medicine_list}', 
              Text('Thuốc: ${prescriptionChildController.responsePrescription.value?.data?.medicines?[0].medicine_list}', 
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0
                  )
                )
              ),
              const SizedBox(height: 15.0),
              // Text('HDSD: ${informationController.responseInfomation.value?.data?.medicines?[0].guide}', 
              Text('HDSD: ${prescriptionChildController.responsePrescription.value?.data?.medicines?[0].guide}', 
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0
                  )
                )
              ),
              const SizedBox(height: 15.0),
              // informationController.responseInfomation.value?.data?.medicines?[0].detail?.isEmpty ?? false 
              prescriptionChildController.responsePrescription.value?.data?.medicines?[0].details?.isEmpty ?? false
              ? Text('Chưa sử dụng', 
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0
                  )
                )
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lịch sử uống',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // itemCount: informationController.responseInfomation.value?.data?.medicines?[0].detail?.length,
                    itemCount: prescriptionChildController.responsePrescription.value?.data?.medicines?[0].details?.length,
                    itemBuilder: (context, index) {
                      // final detailItem = informationController.responseInfomation.value?.data?.medicines?[0].detail?[index];
                      final detailItem = prescriptionChildController.responsePrescription.value?.data?.medicines?[0].details?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          '${detailItem?.created_at} | ${detailItem?.user_fullname}',
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
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () async {
                  await prescriptionChildController.fetchData();
                  Get.to(() => PrescriptionParent());
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.grey
                        )
                      )
                    ),
                    child: Text('Xem chi tiết đơn thuốc >>',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    )
                  ),
                )
              ),
            ]
          ),
        );
      }
    );
  }
}
