import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';

import 'borrow_button_save.dart';

class BorrowAddNew extends StatefulWidget {
  const BorrowAddNew({Key? key}) : super(key: key);

  @override
  State<BorrowAddNew> createState() => BorrowAddNewState();
}

class BorrowAddNewState extends State<BorrowAddNew> {
  DateTime selectedDate = DateTime.now();
  final borrowAdd = Get.find<BorrowController>();

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GestureDetector(
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
                  top: statusBarHeight),
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
                      child: Obx(() => Column(
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
                                          'add-document'.tr,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8.0),
                                  child: Text(
                                    'title-borrow'.tr,
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                CupertinoTextField(
                                  controller: borrowAdd.title,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  placeholder: 'enter-title-borrow'.tr,
                                  placeholderStyle: const TextStyle(
                                      color: Color(0xFFEBE6E8), fontSize: 14),
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
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8.0),
                                  child: Text(
                                    'date-appointment'.tr,
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                CupertinoTextField(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  readOnly: true, // disable manual text input
                                  controller: TextEditingController(
                                    // ignore: unnecessary_null_comparison
                                    text: selectedDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(selectedDate)
                                        : null,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFDFD),
                                    border: Border.all(
                                      color: const Color(0xFFFFFDFD),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  onTap: () async {
                                    final initialDate = selectedDate;
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                        borrowAdd.date.text =
                                            pickedDate.toString();
                                      });
                                    }
                                  },
                                  suffix: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8.0),
                                  child: Text(
                                    '${'title'.tr}*',
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                CupertinoTextField(
                                  controller: borrowAdd.titleBook,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  placeholder: 'enter-title-book'.tr,
                                  placeholderStyle: const TextStyle(
                                      color: Color(0xFFEBE6E8), fontSize: 14),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFFDFD),
                                      border: Border.all(
                                        color: const Color(0xFFFFFDFD),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                borrowAdd.validateTitleBook.value != ""
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8.0),
                                        child: Text(
                                          borrowAdd.validateTitleBook.value,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red)),
                                        ),
                                      )
                                    : const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8.0),
                                  child: Text(
                                    '${'author'.tr}*',
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                CupertinoTextField(
                                  controller: borrowAdd.author,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  placeholder: 'enter-author'.tr,
                                  placeholderStyle: const TextStyle(
                                      color: Color(0xFFEBE6E8), fontSize: 14),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFFDFD),
                                      border: Border.all(
                                        color: const Color(0xFFFFFDFD),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                borrowAdd.validateAuthor.value != ""
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8.0),
                                        child: Text(
                                          borrowAdd.validateAuthor.value,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red)),
                                        ),
                                      )
                                    : const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8.0),
                                  child: Text(
                                    'note-borrow'.tr,
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                CupertinoTextField(
                                  controller: borrowAdd.note,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  placeholder: 'note-borrow'.tr,
                                  placeholderStyle: const TextStyle(
                                      color: Color(0xFFEBE6E8), fontSize: 14),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFFDFD),
                                      border: Border.all(
                                        color: const Color(0xFFFFFDFD),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                              ])),
                    ),
                  ),
                  ButtonSaveDocument(
                    typeSave: 'add',
                    borrowAdd: borrowAdd,
                    title: borrowAdd.title.text,
                    date: borrowAdd.date.text,
                    titleBook: borrowAdd.titleBook.text,
                    author: borrowAdd.author.text,
                    note: borrowAdd.note.text,
                  )
                ],
              )),
            )));
  }

  void handlePressBack() {
    borrowAdd.validateTitleBook.value = "";
    borrowAdd.validateAuthor.value = "";
    Get.back();
  }
}
