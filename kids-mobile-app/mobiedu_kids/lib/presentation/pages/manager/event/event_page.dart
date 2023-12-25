import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_details_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_school_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});

  final eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => InitPage());
        return false;
      },
      child: GetX(
        init: eventController,
        initState: (state) async {
          eventController.page.value = 0;
          eventController.fetch(eventController.page.value);
          eventController.page.value += 1;
          while (eventController.arrlen.value > 0) {
            await eventController.fetch(eventController.page.value);
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
                    Get.off(() => InitPage());
                  },
                  child: Icon(CupertinoIcons.back, color: AppColors.primary),
                ),
              ),
              trailing: Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.delete<EventController>();
                    EventBinding().dependencies();
                    Get.to(() => EventSchoolPage());
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Sự kiện',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(color: AppColors.primary, fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 22.0),
                child: eventController.isLoading.value
                  ? const Center(
                    child: CircularLoadingIndicator()
                  )
                  : eventController.events.isEmpty
                    ? const Center(
                      child: NoData(),
                    )
                    : ListView.separated(
                      itemCount: eventController.events.length,
                      padding: const EdgeInsets.only(bottom: 20.0),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
                      itemBuilder: ((context, index) {
                        return eventController.events[index].for_teacher != '0' 
                          ? const SizedBox() 
                          : GestureDetector(
                            onTap: () {
                              Get.delete<EventController>();
                              EventBinding().dependencies();
                              Get.to(() => EventDetailsPage(
                                event_id: eventController.events[index].event_id,
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
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
                                          "${eventController.events[index].event_name}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                          ),
                                        ),
                                        eventController.events[index].registration_deadline != null && (eventController.events[index].registration_deadline?.isNotEmpty ?? false)
                                          ? Text(
                                            "${eventController.events[index].registration_deadline}",
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                            ),
                                          )
                                          : const SizedBox(),
                                          Row(
                                            children: [
                                              Icon(CupertinoIcons.eye_fill, size: 16.0, color: AppColors.grey),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                "${eventController.events[index].views_count}",
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w500, color: AppColors.black),
                                                ),
                                              )
                                            ]
                                          )
                                      ],
                                    )
                                  )
                                ],
                              )
                            )
                          );
                      }
                    ),
                  )
                )
              )
            )
          )
        );
  }
}
