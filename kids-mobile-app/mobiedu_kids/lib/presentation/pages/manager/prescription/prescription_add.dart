import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/widget/show_pick_image.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class PrescriptionAdd extends StatelessWidget {
  PrescriptionAdd({super.key});

  final prescriptionController = Get.find<PrescriptionController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: prescriptionController,
      builder: (_) {
        return  GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: prescriptionController.isLoading_2.value
          ? SizedBox(
              width: widthScreen,
              child: const Center(
                child: CircularLoadingIndicator(),
              ),
            )
          :  SingleChildScrollView(
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
                    child: Text('Họ tên học sinh',  
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
                    onTap: () {
                      listStudent(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                      width: widthScreen,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey, width: 0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(6.0))
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        prescriptionController.childrenName.value == "" ? "Chọn học sinh" : prescriptionController.childrenName.value,
                        style:  GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey
                          )
                        )
                      )
                    ),
                  ),
                  prescriptionController.validateName.value != '' ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionController.validateName.value,
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
                    controller: prescriptionController.listMenicines,
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
                  prescriptionController.validateListMedicines.value != '' ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionController.validateListMedicines.value,
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
                    controller: prescriptionController.guide,
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
                  prescriptionController.validateGuide.value != '' ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionController.validateGuide.value,
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
                    controller: prescriptionController.numberOfUses,
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
                  prescriptionController.validateNumberOfUses.value != "" ?  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                    child: Text(prescriptionController.validateNumberOfUses.value,
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
                            DateFormat('dd-MM-yyyy').format(prescriptionController.startDate),
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
                          Text(DateFormat('dd-MM-yyyy').format(prescriptionController.endDate),
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
                  prescriptionController.selectedImageSize.value == '' 
                  ? GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => ShowPickImage())
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
                          prescriptionController.selectedImagePath.value.isNotEmpty ? Image.file(File(prescriptionController.selectedImagePath.value)) : Container(),
                          Positioned(
                            top: 0,
                            right: 24.0,
                            child: GestureDetector(
                            onTap: () {
                              prescriptionController.clearImage();
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
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(bottom: bottomPadding + 10.0),
                    width: widthScreen,
                    child: CupertinoButton(
                      onPressed: prescriptionController.isCreatePrescription.value ? null : () {
                        prescriptionController.add(context);
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

void listStudent(BuildContext context) {
  double heightScreen = MediaQuery.of(context).size.height;
  final prescriptionController = Get.find<PrescriptionController>();
  final data = prescriptionController.responseListChild.value?.data?.child_list;

  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: heightScreen / 3,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Hủy',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    prescriptionController.childrenID.value =  int.parse(data?[prescriptionController.childrenIndex.value].child_id ?? "0");
                    prescriptionController.childrenName.value =  data?[prescriptionController.childrenIndex.value].child_name ?? "" ;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Chọn',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: 32.0,
              scrollController: FixedExtentScrollController(
                initialItem: prescriptionController.childrenIndex.value,
              ),
              onSelectedItemChanged: (int selectedItem) {
                prescriptionController.childrenIndex.value = selectedItem;
                prescriptionController.childrenID.value =  int.parse(data?[prescriptionController.childrenIndex.value].child_id ?? "0");
                prescriptionController.childrenName.value =  data?[prescriptionController.childrenIndex.value].child_name ?? "" ;
              },
              children: List<Widget>.generate(
                prescriptionController.responseListChild.value?.data?.child_list?.length ?? 0, 
                (int index) {
                  return Center(
                    child: Text(
                      prescriptionController.responseListChild.value?.data?.child_list?[index].child_name ?? "Lớp học không có học sinh"
                    )
                  );
                }
              ),
            )),
          ],
        ),
      ),
    ),
  );
}

Future<void> selectDateRange(BuildContext context) async {
  final prescriptionController = Get.find<PrescriptionController>();

  final DateTimeRange? picked = await showDateRangePicker(
    initialEntryMode: DatePickerEntryMode.input,
    context: context,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    initialDateRange: DateTimeRange(
      start: prescriptionController.startDate,
      end: prescriptionController.endDate,
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
    prescriptionController.startDate = picked.start;
    prescriptionController.endDate = picked.end;
  }
}