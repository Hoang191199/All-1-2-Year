import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/register_event.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage({super.key, this.event_id});

  final String? event_id;

  final eventController = Get.find<EventController>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: eventController,
      initState: (state) async {
        await eventController.detail(event_id ?? "");
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
                textStyle: TextStyle(color: AppColors.primary, fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: 22.0),
              child: eventController.isLoadingDetail.value ? 
                const Center(
                  child: CircularLoadingIndicator()
                ) : 
                Column(
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
                            "${eventController.event_details.value?.event_name}",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0, 
                                height: 1.28, 
                                color: AppColors.primary, fontWeight: FontWeight.w700),
                            ),
                          )
                        )
                      ]
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/flag.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          "Phạm vi: ${getEventLevelName()}",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.black)
                          ),
                        ),
                      ]
                    ),
                    const Divider(),
                    eventController.event_details.value?.registration_deadline != null && (eventController.event_details.value ?.registration_deadline?.isNotEmpty ?? false)
                      ? Row(
                        children: [
                          Image.asset(
                            'assets/images/register.png',
                            width: 24.0,
                            height: 24.0,
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            "Hạn đăng ký: ${eventController.event_details.value?.registration_deadline}",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.black)
                            ),
                          ),
                        ]
                      )
                      : const SizedBox(),
                      eventController.event_details.value?.registration_deadline != null && (eventController.event_details.value?.registration_deadline?.isNotEmpty ?? false)
                        ? const Divider()
                        : const SizedBox(),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Html(
                            data: "${eventController.event_details.value?.description}",
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
                          ),
                        )
                      ),
                      eventController.event_details.value?.must_register == '1' && ((eventController.event_details.value?.registration_deadline == "" || eventController.event_details.value?.registration_deadline == null) ? true : DateTime.now().isBefore(DateFormat("hh:mm dd/MM/yyyy").parse(eventController.event_details.value?.registration_deadline ?? DateFormat("hh:mm dd/MM/yyyy").format(DateTime.now()))))
                      ?  Container(
                        padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widthScreen - 56,
                              child: CupertinoButton(
                                onPressed: () async {
                                  Get.to(() => RegisterEvent(
                                        event_id: event_id,
                                  ));
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
                        )) : const SizedBox()
                    ],
                  )
                )
              )
            )
          );
  }

  String getEventLevelName() {
    switch (eventController.event_details.value?.level) {
      case '1':
        return 'Trường';
      case '2':
        return 'Khối';
      case '3':
        return 'Lớp';
      default:
        return '';
    }
  }
}
