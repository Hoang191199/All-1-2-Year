import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';

class PickImagePrescriptionChild extends StatelessWidget {
  PickImagePrescriptionChild({Key? key}) : super(key: key);

  final prescriptionChildController = Get.find<PrescriptionChildController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Chọn ảnh thuốc",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black
              )
            )
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.camera,
                color: Colors.teal,
              ),
              onPressed: () async {
                prescriptionChildController.getImage(ImageSource.camera, context);
              },
              label: const Text(
                "Máy ảnh",
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.image,
                color: Colors.teal,
              ),
              onPressed: () async {
                prescriptionChildController.pickImageFromGallery(context);
              },
              label: const Text(
                "Thư viện ảnh",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
