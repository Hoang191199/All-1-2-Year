import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/widget/pick_image_prescription_child.dart';

class PrescriptionRegister extends StatelessWidget {
  PrescriptionRegister({super.key});

  final prescriptionChildController = Get.find<PrescriptionChildController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: prescriptionChildController,
      builder: (_) {
        return GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text('Tạo đơn thuốc mới',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary
                        )
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Danh sách thuốc',  
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CupertinoTextField(
                    controller: prescriptionChildController.listMenicines,
                    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                    placeholder: "Danh sách thuốc (*)",
                    placeholderStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    ),
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    )
                  ),
                  prescriptionChildController.validateListMedicines.value != '' ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionChildController.validateListMedicines.value,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pink
                        )
                      )
                    ) 
                  )
                  :const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Hướng dẫn sử dụng',  
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black
                      )
                    )
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CupertinoTextField(
                    controller: prescriptionChildController.guide,
                    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                    placeholder: "Hướng dẫn sử dụng (*)",
                    placeholderStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    ),
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    ),
                    maxLines: 3,
                  ),
                  prescriptionChildController.validateGuide.value != '' ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionChildController.validateGuide.value,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pink
                        )
                      )
                    ) 
                  )
                  :const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Số lần sử dụng/ngày',  
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CupertinoTextField(
                    controller: prescriptionChildController.numberOfUses,
                    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                    placeholder: "Số lần",
                    placeholderStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    ),
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey
                      )
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 1
                  ),
                  prescriptionChildController.validateNumberOfUses.value != "" ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionChildController.validateNumberOfUses.value,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pink
                        )
                      )
                    ) 
                  )
                  :const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Ngày hết hạn',  
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: (){
                      selectDateRange(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                      width: widthScreen,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey, width: 0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(6.0))
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy').format(prescriptionChildController.startDate),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black
                              )
                            )
                          ),
                          const SizedBox(width: 10.0),
                          Icon(
                            CupertinoIcons.arrow_right,
                            color: AppColors.grey,
                            size: 24.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(DateFormat('dd-MM-yyyy').format(prescriptionChildController.endDate),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    return prescriptionChildController.selectedImageSize.value == '' 
                    ? GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => PickImagePrescriptionChild())
                        );   
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.primary, width: 1
                              )
                            )
                          ),
                          child: Text(
                            "Ảnh đơn thuốc", 
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary
                              )
                            ),
                          ),
                        ),
                      )
                    )
                    : Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                      width: widthScreen / 3,
                      height: 130.0,
                        child: Stack(
                          children: [
                            prescriptionChildController.selectedImagePath.value.isNotEmpty ? Image.file(File(prescriptionChildController.selectedImagePath.value)) : Container(),
                            Positioned(
                              top: 0,
                              right: 24.0,
                              child: GestureDetector(
                              onTap: () {
                                prescriptionChildController.clearImage();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    );
                  }),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(bottom: bottomPadding + 10.0),
                    width: widthScreen,
                    child: CupertinoButton(
                      onPressed: prescriptionChildController.isCreatePrescription.value ? null : () {
                        prescriptionChildController.register(context);
                      },
                      padding: const EdgeInsets.all(16.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      color: AppColors.pink,
                      alignment: Alignment.center,
                      child: Text(
                        'Gửi',
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
                  ),
                ]
              ),
            ),
          )
        );
      }
    );
  }
}


Future<void> selectDateRange(BuildContext context) async {
  final prescriptionChildController = Get.find<PrescriptionChildController>();

  final DateTimeRange? picked = await showDateRangePicker(
    initialEntryMode: DatePickerEntryMode.input,
    context: context,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    initialDateRange: DateTimeRange(
      start: prescriptionChildController.startDate,
      end: prescriptionChildController.endDate,
    ),
    helpText: 'Chọn ngày', // Can be used as title
    cancelText: 'Hủy',
    confirmText: 'Lưu',
    errorFormatText: 'Vui lòng nhập ngày',
    errorInvalidText: 'Vui lòng nhập ngày',
    errorInvalidRangeText: 'Vui lòng nhập ngày',
    fieldStartLabelText: 'Từ ngày',
    fieldStartHintText: 'ngày/tháng/năm',
    fieldEndLabelText: 'Đến ngày',
    fieldEndHintText: 'ngày/tháng/năm',
  );
  if (picked != null) {
    prescriptionChildController.startDate = picked.start;
    prescriptionChildController.endDate = picked.end;
  }
}