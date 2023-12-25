import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/image_menu.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/meal_menu.dart';

class ListSchedule extends StatelessWidget {
  ListSchedule({
    super.key,
    required this.day,
    this.details
  });

  final checkbox = Get.put(CheckBoxController());
  final String? day;
  final bool? details;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthScreen,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              details == true ? (checkbox.scheduleController.detailSchedule.value?.details?.length ?? 0) : checkbox.scheduleController.data.length,
              (index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.lightPink2,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: (widthScreen - 56) / 3,
                  child: Column(
                    children: [
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].subject_name) : checkbox.scheduleController.data[index]?.subject_name, 
                        checkColor: false
                      ),
                      const SizedBox(height: 10),
                      index % 3 == 0 ? 
                      const ImageMenu(image: 'assets/images/activity_sprite_1.png') : 
                      index % 3 == 1 ?
                      const ImageMenu(image: 'assets/images/activity_sprite_2.png') :  
                      const ImageMenu(image: 'assets/images/activity_sprite_3.png') ,
                      const SizedBox(height: 10),
                      if(day == 'monday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].monday) : checkbox.scheduleController.data[index]?.monday, 
                        checkColor: true
                      ),
                      if(day == 'tuesday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].tuesday) : checkbox.scheduleController.data[index]?.tuesday, 
                        checkColor: true
                      ),
                      if(day == 'wednesday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].wednesday) : checkbox.scheduleController.data[index]?.wednesday, 
                        checkColor: true
                      ),
                      if(day == 'thursday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].thursday) : checkbox.scheduleController.data[index]?.thursday, 
                        checkColor: true
                      ),
                      if(day == 'friday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].friday) : checkbox.scheduleController.data[index]?.friday, 
                        checkColor: true
                      ),
                      if(day == 'saturday')
                      MealName(
                        title: details == true ? (checkbox.scheduleController.detailSchedule.value?.details?[index].saturday) : checkbox.scheduleController.data[index]?.saturday, 
                        checkColor: true
                      ),
                      const SizedBox(height: 10.0),
                    ]
                  ),
                )
              ),
            ),
          )
        )
      )
    );
  }
}