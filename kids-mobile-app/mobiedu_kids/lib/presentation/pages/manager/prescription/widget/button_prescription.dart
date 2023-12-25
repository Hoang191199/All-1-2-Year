import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';

class ButtonPrescription extends StatelessWidget {
  ButtonPrescription(
    {
      super.key,
      required this.type,
      required this.child_id,
      required this.medicine_id,
      this.max
    });
  final String type;
  final int child_id;
  final int medicine_id;
  final int? max;

  final prescriptionController = Get.find<PrescriptionController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150.0,
          height: 55.0,
          child: CupertinoButton(
            onPressed: () {
              if (type != "medicate") {
                prescriptionController.takemedicines(
                    medicine_id, type, child_id, max, context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
            color: const Color(0xFFF2F2F2),
            alignment: Alignment.center,
            child: Text(
              type != "medicate" ? 'Hủy đơn thuốc' : 'Hủy',
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
        ),
        SizedBox(
          width: 150.0,
          height: 55.0,
          child: CupertinoButton(
            onPressed: () {
              if (type == "medicate") {
                prescriptionController.takemedicines(
                  medicine_id, 
                  type, 
                  child_id, 
                  max, 
                  context
                );
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
            color: type != "medicate" ? AppColors.pink : AppColors.green,
            alignment: Alignment.center,
            child: Text(
              type != "medicate" ? 'Bỏ qua' : 'OK',
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
    );
  }
}
