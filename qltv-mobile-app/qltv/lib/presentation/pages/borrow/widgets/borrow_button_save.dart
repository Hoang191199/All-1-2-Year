import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';

class ButtonSaveDocument extends StatelessWidget {
  const ButtonSaveDocument(
    {
      super.key,
      required this.typeSave,
      this.borrowAdd,
      this.borrowUpdate,
      this.id,
      this.title,
      required this.date,
      required this.titleBook,
      required this.author,
      this.note
    }
  );

  final BorrowController? borrowAdd;
  final BorrowController? borrowUpdate;
  final String typeSave;
  final int? id;
  final String? title;
  final String date;
  final String titleBook;
  final String author;
  final String? note;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SizedBox(
            width: widthScreen / 2,
            height: 50,
            child: 
            // Obx(
            //   () => 
              ElevatedButton(
                onPressed: typeSave == 'add' ? () {
                  borrowAdd?.addBorrow(title, date, titleBook, author, note, context);
                } : () {
                  borrowUpdate?.updateBorrow(id ?? 0, title, titleBook, author, note, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // đặt màu nền là xanh lam
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text(
                  'save-borrow'.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            )),
    );
  }
}
