import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_details_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class EventSchoolPage extends StatelessWidget {
  EventSchoolPage({super.key});

  final eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: GetX(
        init: eventController,
        initState: (state) async {
          eventController.page.value = 0;
          eventController.fetchSchool(eventController.page.value);
          eventController.page.value += 1;
          while (eventController.arrlen.value > 0) {
            await eventController.fetchSchool(eventController.page.value);
            eventController.page.value += 1;
          }
          eventController.page.value = 0;
        },
        builder: (state) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 12.0),
              leading: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Sự kiện cho nhân viên',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20),
              child: eventController.isLoading.value ? 
              const Center(
                child: CircularLoadingIndicator()
              ) : 
              eventController.eventsSchool.isEmpty ? 
              const NoData() : 
              ListView.separated(
                itemCount: eventController.eventsSchool.length,
                itemBuilder: ((context, index) =>
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EventDetailsPage(
                        event_id: eventController.eventsSchool[index].event_id
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(10.0),
                            color: AppColors.lightPink,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(11.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.pink
                                ),
                                child: Image.asset(
                                  'assets/images/Vector.png',
                                  width: 26.0,
                                  height: 26.0,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${eventController.eventsSchool[index].event_name}",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 14.0, 
                                          fontWeight: FontWeight.w500, 
                                          color: AppColors.black
                                        ),
                                      ),
                                    ),
                                    eventController.eventsSchool[index].registration_deadline != "" && eventController.eventsSchool[index].registration_deadline != null ? 
                                    Text(
                                      "${eventController.eventsSchool[index].registration_deadline}",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                      ),
                                    ) : const SizedBox(),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.eye_fill, 
                                          size: 16.0, 
                                          color: AppColors.grey
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${eventController.eventsSchool[index].views_count}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 12.0, 
                                              height: 1.4, 
                                              fontWeight: FontWeight.w500, 
                                              color: AppColors.black
                                            ),
                                          ),
                                        )
                                      ]
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                      ]
                    )
                  )
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              )
            )
          )
        )
      )
    );
  }
}
