import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/event/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';

class EventChildDetailsPage extends StatelessWidget {
  EventChildDetailsPage({super.key, required this.index});

  final int index;

  final eventController = Get.find<EventController>();
  final store = Get.find<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: eventController,
      initState: (state) async {
        eventController.checkChildInvi.value = eventController.eventsChild[index].participants?.child?.is_registered ?? false;
        eventController.checkParentInvi.value = eventController.eventsChild[index].participants?.parent?.is_registered ?? false;
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
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back, color: AppColors.primary),
              ),
            ),
            middle: Text(
              'Chi tiết sự kiện',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(color: AppColors.primary, fontSize: 22.0, fontWeight: FontWeight.w700)
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/check_calendar.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        "${eventController.eventsChild[index].event_name}",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: 14.0, height: 1.28, color: AppColors.primary, fontWeight: FontWeight.w700),
                        ),
                      )
                    )
                  ]
                ),
                const Divider(),
                eventController.eventsChild[index].registration_deadline != null && (eventController.eventsChild[index].registration_deadline?.isNotEmpty ?? false)
                  ? Row(
                    children: [
                      Image.asset(
                        'assets/images/register.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        "Hạn đăng ký: ${eventController.eventsChild[index].registration_deadline}",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.black)
                        ),
                      ),
                    ]
                  )
                  : const SizedBox(),
                eventController.eventsChild[index].registration_deadline != null && (eventController.eventsChild[index].registration_deadline?.isNotEmpty ?? false)
                  ? const Divider()
                  : const SizedBox(),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: widthScreen - 56.0,
                            child: Html(
                              data: "${eventController.eventsChild[index].description}",
                              style: {
                                'body': Style(
                                  lineHeight: const LineHeight(1.4),
                                  fontSize: FontSize(12.0),
                                  color: HexColor('464646'),
                                  fontFamily: 'Raleway',
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero
                                )
                              }
                            )
                          )
                        ]
                      ),
                      eventController.eventsChild[index].participants != null
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (eventController.eventsChild[index].for_child == '1')
                              Row(
                                children: [
                                  GetBuilder<CheckBoxEventController>(
                                    init: CheckBoxEventController(),
                                    builder: (controller) => CupertinoCheckbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.green,
                                      value: CheckBoxEventController.to.eventController.checkChildInvi.value,
                                      onChanged: (bool? value) {
                                        CheckBoxEventController.to.toggleEventChildChild(value);
                                      }
                                    )
                                  ),
                                  Text(
                                    "Học sinh",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black)
                                    )
                                  )
                                ],
                              ),
                            if (eventController.eventsChild[index].for_parent == '1')
                              Row(
                                children: [
                                  GetBuilder<CheckBoxEventController>(
                                    init: CheckBoxEventController(),
                                    builder: (controller) => CupertinoCheckbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.green,
                                      value: CheckBoxEventController.to.eventController.checkParentInvi.value,
                                      onChanged: (bool? value) {
                                        CheckBoxEventController.to.toggleEventParentChild(value);
                                      }
                                    )
                                  ),
                                  Text(
                                    "Phụ huynh",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black)
                                    ),
                                  )
                                ],
                              )
                          ],
                        )
                        : const SizedBox(),
                      ],
                    )
                  ),
                  eventController.eventsChild[index].must_register == '1' && ((eventController.eventsChild[index].registration_deadline == "" || eventController.eventsChild[index].registration_deadline == null) ? true : DateTime.now().isBefore(DateFormat("hh:mm dd/MM/yyyy").parse(eventController.eventsChild[index].registration_deadline ?? DateFormat("hh:mm dd/MM/yyyy").format(DateTime.now()))))
                    ? Container(
                      padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthScreen - 56,
                            child: CupertinoButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await eventController.registerChild(
                                  store.getChild?.child_id ?? "",
                                  eventController.eventsChild[index].event_id ?? "",
                                  eventController.checkChildInvi.value ? "1" : "0",
                                  eventController.checkParentInvi.value ? "1" : "0"
                                );
                                eventController.page.value = 0;
                                eventController.eventsChild.value = [];
                                await eventController.fetchChild(
                                  eventController.page.value,
                                  store.getChild?.child_id ?? ""
                                );
                                eventController.page.value += 1;
                                while (eventController.arrlen.value > 0) {
                                  await eventController.fetchChild(
                                    eventController.page.value,
                                    store.getChild?.child_id ?? ""
                                  );
                                  eventController.page.value += 1;
                                }
                                eventController.page.value = 0;
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.pink,
                              child: Text(
                                'Đăng ký',
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w700),
                                ),
                              )
                            )
                          ),
                        ]
                      ),
                    )
                    : const SizedBox()
                  ],
                )
              )
            )
          )
        );
  }
}
