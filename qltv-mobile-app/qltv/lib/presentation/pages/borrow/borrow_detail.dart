import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_detail_controller.dart';
import 'package:qltv/presentation/pages/borrow/widgets/borrow_button_save.dart';

class BorrowDetail extends StatelessWidget {
  BorrowDetail({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);

  final int id;
  final String type;

  final borrowDetailController = Get.find<BorrowDetailController>();
  final borrowUpdate = Get.find<BorrowController>();

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return GetX(
        init: borrowDetailController,
        initState: (state) {
          borrowDetailController.fetchDetail(id);
        },
        builder: (_) {
          return borrowDetailController.isLoading.value
              ? Container(
                  width: widthScreen - 28.0 - 28.0,
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Scaffold(
                    backgroundColor: AppColors.background,
                    resizeToAvoidBottomInset: false,
                    body: Container(
                      padding: EdgeInsets.only(
                          bottom: bottomPadding + 20.0,
                          left: 16.0,
                          right: 16.0,
                          top: statusBarHeight
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: bottomInsets),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              padding: const EdgeInsets.only(right: 14),
                                              icon: const Icon(
                                                Icons.chevron_left_sharp,
                                                size: 34,
                                                color: Color(0xFF7B858B),
                                              ),
                                              onPressed: () {
                                                handlePressBack();
                                              },
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${'lending-request'.tr} ${checkStatus(borrowDetailController.responseData.value?.data?.status ?? 0)}',
                                                  style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.black
                                                    )
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                        child: Text(
                                          'title-borrow'.tr,
                                          style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ),
                                      CupertinoTextField(
                                        controller: borrowUpdate.title,
                                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                        placeholder: borrowDetailController.responseData.value?.data?.title ??'',
                                        enabled: type == 'detail' ? false : true,
                                        placeholderStyle: const TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFDFD),
                                          border: Border.all(
                                            color: const Color(0xFFFFFDFD),
                                            width: 2,
                                          ),
                                          borderRadius:BorderRadius.circular(14)
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                        child: Text(
                                          'date-appointment'.tr,
                                          style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ),
                                      CupertinoTextField(
                                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                        readOnly: true,
                                        enabled: type == 'detail' ? false : true, // disable manual text input
                                        controller: borrowDetailController.dateTimes,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFDFD),
                                          border: Border.all(
                                            color: const Color(0xFFFFFDFD),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        onTap: () async {
                                          final initialDate = borrowDetailController.localDateTime;
                                          final pickedDate = await showDatePicker(
                                            context: Get.context!,
                                            initialDate: initialDate,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100),
                                          );
                                          if (pickedDate != null) {
                                            borrowDetailController.dateTimes.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                                            borrowUpdate.date.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                                          }
                                        },
                                        suffix: const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            color:Color.fromRGBO(0, 0, 0, 0.25),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                        child: Text(
                                          '${'title'.tr} *',
                                          style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ),
                                      CupertinoTextField(
                                        controller: borrowUpdate.titleBook,
                                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                        enabled: type == 'detail' ? false : true,
                                        placeholder:  '${borrowDetailController.responseData.value?.data?.items?[0].title}',
                                        placeholderStyle: const TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFDFD),
                                          border: Border.all(
                                            color: const Color(0xFFFFFDFD),
                                            width: 2,
                                          ),
                                        borderRadius: BorderRadius.circular(14)),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                        child: Text(
                                          '${'author'.tr} *',
                                          style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ),
                                      CupertinoTextField(
                                        controller: borrowUpdate.author,
                                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                        enabled: type == 'detail' ? false : true,
                                        placeholder: '${borrowDetailController.responseData.value?.data?.items?[0].author}',
                                        placeholderStyle: const TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16
                                        ),
                                        decoration: BoxDecoration(color: const Color(0xFFFFFDFD),
                                          border: Border.all(
                                            color: const Color(0xFFFFFDFD),
                                            width: 2,
                                          ),
                                        borderRadius:BorderRadius.circular(14)),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                        child: Text(
                                          'note-borrow'.tr,
                                          style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                      ),
                                      CupertinoTextField(
                                        controller: borrowUpdate.note,
                                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                        enabled: type == 'detail' ? false : true,
                                        placeholder: borrowDetailController.responseData.value?.data?.note,
                                        placeholderStyle: const TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFDFD),
                                          border: Border.all(
                                            color: const Color(0xFFFFFDFD),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(14)),
                                      ),
                                      const SizedBox(height: 16),
                                      type == 'detail' ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                                            child: Text('status'.tr,
                                              style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:FontWeight.w700
                                                )
                                              ),
                                            ),
                                          ),
                                          CupertinoTextField(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 16
                                            ),
                                            enabled: false,
                                            placeholder: checkStatus(borrowDetailController.responseData.value?.data?.status ?? 0),
                                            placeholderStyle: const TextStyle(
                                              color:Color(0xFF333333),
                                              fontSize: 14
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFFDFD),
                                              border: Border.all(
                                              color: const Color(0xFFFFFDFD),
                                              width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(14)
                                            ),
                                          ),
                                        ],
                                      ) : const SizedBox(),
                                      const SizedBox(height: 16),
                                      borrowDetailController.responseData.value?.data?.status != -1
                                      ? const SizedBox()
                                      : Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:const EdgeInsets.only(left: 16,bottom: 8.0),
                                            child: Text('reason-for-refusal'.tr,
                                              style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:FontWeight.w700
                                                )
                                              ),
                                            ),
                                          ),
                                          CupertinoTextField(
                                            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                                            enabled: false,
                                            placeholder:borrowDetailController.responseData.value?.data?.reject_message,
                                            placeholderStyle:const TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 14
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFFDFD),
                                              border: Border.all(
                                                color: const Color(0xFFFFFDFD),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(14)
                                            ),
                                          ),
                                        ]
                                      ),
                                    ]
                                  )
                                ),
                            ),
                            type != 'detail' ? ButtonSaveDocument(
                              typeSave: 'update',
                              id: id,
                              borrowUpdate: borrowUpdate,
                              title: borrowUpdate.title.text == '' ? borrowDetailController.responseData.value?.data?.title : borrowUpdate.title.text,
                              date: borrowUpdate.date.text,
                              titleBook: borrowUpdate.titleBook.text == '' ? (borrowDetailController.responseData.value?.data?.items?[0].title) ?? '' 
                                : borrowUpdate.titleBook.text,
                              author: borrowUpdate.author.text == '' ? (borrowDetailController.responseData.value?.data?.items?[0].author) ?? '' : borrowUpdate.author.text,
                              note: borrowUpdate.note.text == '' ? borrowDetailController.responseData.value?.data?.note : borrowUpdate.note.text,
                            )
                            : const SizedBox()
                        ],
                      )
                    ), //
                  ),
                )
              );
            }
        );
  }

  void handlePressBack() {
    Get.delete<BorrowDetailController>();
    Get.back();
  }
}

String checkStatus(int status) {
  switch (status) {
    case -1:
      return 'denied'.tr;
    case 0:
      return 'not-approved'.tr;
    case 1:
      return 'approved'.tr;
    default:
      return '';
  }
}
