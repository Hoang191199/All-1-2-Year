import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/meal.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_binding.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/note_widget.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/menu/menu_page.dart';

class MenuInfo extends StatelessWidget {
  MenuInfo({super.key});

  final informationController = Get.find<InformationController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    ScheduleReviewBinding().dependencies();
    ScheduleBinding().dependencies();
    MenuBinding().dependencies();
    MenuReviewBinding().dependencies();
    Get.put(CheckBoxController());
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      width: widthScreen,
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: informationController.responseMenu.value?.data?.menu_child?.details?.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10),
                  ),
                  color: AppColors.lightPink2,
                  child: Container(
                  padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${informationController.responseMenu.value?.data?.menu_child?.details?[index].meal_name}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color:AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0
                          )
                        )
                      ),
                      const SizedBox( height: 10),
                        index % 3 == 0
                          ? Image.asset('assets/images/meal_sprite_1.png',
                              width: 40.0,
                              height: 50,
                              fit: BoxFit.contain,
                            )
                        : index % 3 == 1
                          ? Image.asset('assets/images/meal_sprite_2.png',
                              width: 40.0,
                              height: 50.0,
                              fit: BoxFit.contain,
                            )
                          : Image.asset('assets/images/meal_sprite_3.png',
                              width: 40.0,
                              height: 50.0,
                              fit: BoxFit.contain,
                            ),
                        const SizedBox(height: 10),
                        Text(
                          checkShowMenu(informationController.responseMenu.value?.data?.menu_child?.details?[index]),
                          overflow:TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        )
                      ]
                    ),
                  )
                );
              },
            )
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Get.to(()=> MenuChildPage(child_id: store.getChild?.child_id));
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
                child: Text('Xem thực đơn tuần >>',
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
          (informationController.typeMenu.value?.note == null || informationController.typeMenu.value?.note == '') ? const SizedBox() :
          const SizedBox(height: 16.0),
          (informationController.typeMenu.value?.note == null || informationController.typeMenu.value?.note == '') ? const SizedBox() :
          NoteWidget(note: informationController.typeMenu.value?.note ?? ''),
        ]
      )
    );
  }

  checkShowMenu(Meal? menu){
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);
    
    if(dayOfWeek == 'Monday'){
      return '${menu?.monday}';
    }else if(dayOfWeek == 'Tuesday'){
      return '${menu?.tuesday}';
    }else if(dayOfWeek == 'Wednesday'){
      return '${menu?.wednesday}';
    }else if(dayOfWeek == 'Thursday'){
      return '${menu?.thursday}';
    }else if(dayOfWeek == 'Friday'){
      return '${menu?.friday}';
    }else if(dayOfWeek == 'Saturday'){
      return '${menu?.saturday}';
    }
  }
}
