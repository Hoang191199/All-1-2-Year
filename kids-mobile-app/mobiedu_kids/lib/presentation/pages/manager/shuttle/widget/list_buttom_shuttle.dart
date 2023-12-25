import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';

class ListButtonShuttle extends StatelessWidget {
  ListButtonShuttle({super.key, 
    this.status,
    this.time,
    required this.pickup_id,
    required this.child_id,
    this.late_pickup_free,
    this. total_amount,
    this.pickup_at,
    this.stt,
    this.service
  });

  final String? status;
  final String? time;
  final int pickup_id;
  final int child_id;
  final String? late_pickup_free;
  final int? total_amount;
  final String? pickup_at;
  final int? stt;
  final List<String>? service;

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (status == '0' && time == "") ? 100 : 150, 
            height: 40,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onPressed: (){
                shuttleController.cancelPickup(pickup_id, child_id, context);
              },
              color: const Color(0xFFF2F2F2),
              child: Text('Hủy',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ), 
            ),
          ),
          (status == '0' && time == "") ?
          SizedBox(
            width: 100,
            height: 40,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onPressed: () {
                shuttleController.pickUp(
                  pickup_id, 
                  child_id, 
                  context
                );
                shuttleController.savePickup(
                  pickup_id, 
                  child_id, 
                  late_pickup_free, 
                  total_amount, 
                  pickup_at, 
                  stt, 
                  service,
                  'Trả',
                  '0', 
                  context
                );
              },
              color: const Color(0xFFF2F2F2),
              child: Text(
                'Trả học sinh',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ): const SizedBox(),
          SizedBox(
            width: (status == '0' && time == "") ? 100 : 150,
            height: 40,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onPressed: () {
                shuttleController.savePickup(
                  pickup_id, 
                  child_id, 
                  late_pickup_free, 
                  total_amount, 
                  pickup_at, 
                  stt, 
                  service,
                  'Lưu', 
                  '1',
                  context
                );
              },
              color: AppColors.pink,
              child: Text(
                'Lưu',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
