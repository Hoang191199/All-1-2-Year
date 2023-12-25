import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/schedule/schedule_detail_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';
import 'package:mobiedu_kids/presentation/widgets/rank_ranger.dart';

class ScheduleHistoryChildPage extends StatelessWidget {
  ScheduleHistoryChildPage({super.key});

  final checkbox = Get.put(CheckBoxController());
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {

    return GetX(
      init: checkbox.scheduleController,
      initState: (state) async {
        await checkbox.scheduleController.historyChild(0, store.getChild?.child_id ?? "");
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 12.0),
              leading: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Lịch học',
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
            child: checkbox.scheduleController.ishistoryLoading.value ? 
            const Center(
              child: CircularLoadingIndicator()
            ) : 
            checkbox.scheduleController.historySchedule.isEmpty ? 
            const NoData() : 
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20),
              child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ScheduleDetailsChildPage(schedule_id: checkbox.scheduleController.historySchedule[index].schedule_id,));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${checkbox.scheduleController.historySchedule[index].schedule_name} cho ${checkbox.scheduleController.historySchedule[index].level}",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                              Text(
                                "Áp dụng từ ${checkbox.scheduleController.historySchedule[index].begin}",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 12.0,
                                    color:AppColors.grey,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  checkbox.scheduleController.historySchedule[index].applied_for == "1" ? 
                                  const RankRanger(title: "Phạm vi cấp trường") : 
                                  checkbox.scheduleController.historySchedule[index].applied_for == "2" ? 
                                  const RankRanger(title: "Phạm vi cấp khối lớp") :
                                  const RankRanger(title: "Phạm vi cấp lớp")
                                ]
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: checkbox.scheduleController.historySchedule.length
              )
            )
          )
        )
      )
    );
  }
}
