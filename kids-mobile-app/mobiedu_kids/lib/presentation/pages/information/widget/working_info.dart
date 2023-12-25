import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/activity.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_binding.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/note_widget.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/schedule/schedule_page.dart';

class WorkingInfo extends StatelessWidget {
  WorkingInfo({super.key});

  final informationController = Get.find<InformationController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    ScheduleReviewBinding().dependencies();
    ScheduleBinding().dependencies();
    MenuBinding().dependencies();
    MenuReviewBinding().dependencies();
    Get.put(CheckBoxController());

    return Container(
      width: widthScreen,
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          Text('${informationController.responseSchedule.value?.data?.schedule_child?.schedule_name}',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ),
          Text('${informationController.responseSchedule.value?.data?.schedule_child?.description}',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.grey,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ),
          const SizedBox(height: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              informationController.responseSchedule.value?.data?.schedule_child?.details?.length ?? 0,
              (index) => Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widthScreen / 4 - 28,
                      child: Text('${informationController.responseSchedule.value?.data?.schedule_child?.details?[index].subject_time}',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Container(
                        width: widthScreen,
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: const BorderRadius.all(Radius.circular(14.0))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${informationController.responseSchedule.value?.data?.schedule_child?.details?[index].subject_name}',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ),
                            Text('${checkShowSchedule(informationController.responseSchedule.value?.data?.schedule_child?.details?[index])}',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      )
                    )
                  ],
                )
              ),
            ).toList(),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: (){
              Get.to(()=> ScheduleChildPage(child_id: store.getChild?.child_id));
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
                child: Text('Xem lịch học tuần >>',
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
            ),
          ),
          (informationController.typeSchedule.value?.note == null || informationController.typeSchedule.value?.note == '') ? const SizedBox() :
          const SizedBox(height: 16.0),
          (informationController.typeSchedule.value?.note == null || informationController.typeSchedule.value?.note == '') ? const SizedBox() :
          NoteWidget(note: informationController.typeSchedule.value?.note ?? '')
        ]
      ),
    );
  }

  checkShowSchedule(Activity? menu) {
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);

    if (dayOfWeek == 'Monday') {
      return '${menu?.monday}';
    } else if (dayOfWeek == 'Tuesday') {
      return '${menu?.tuesday}';
    } else if (dayOfWeek == 'Wednesday') {
      return '${menu?.wednesday}';
    } else if (dayOfWeek == 'Thursday') {
      return '${menu?.thursday}';
    } else if (dayOfWeek == 'Friday') {
      return '${menu?.friday}';
    } else if (dayOfWeek == 'Saturday') {
      return '${menu?.saturday}';
    }
  }
}
