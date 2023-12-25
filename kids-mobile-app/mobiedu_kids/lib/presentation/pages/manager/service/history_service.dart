import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/widget/item_service_in_history.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/widget/show_date_now.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class HistoryService extends StatelessWidget {
  HistoryService({
    super.key,
    required this.tabs
  });

  final String? tabs;

  final serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    serviceController.tabs.value = 'history-service';

    return GetX(
      init: serviceController,
      builder: (_) { 
        return serviceController.isLoadingHistory.value ?
        const SizedBox(
            child: Center(
              child: CircularLoadingIndicator(),
            ),
          )
        :Container(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Chọn ngày:', 
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: (){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => ShowDateNow()
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGrey,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(convertDateTimeToString(serviceController.dateHistory), 
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          const SizedBox(width:20.0),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.lightGrey,
                            weight: 12.0,
                          )
                        ],
                      )
                    ),
                  ),
                  
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: serviceController.responseHistory.value?.data?.history?.length,
                  itemBuilder: (context, index) {
                    serviceController.isShow.value = List.generate(serviceController.responseHistory.value?.data?.history?.length ?? 0, (_) => true).map((_) => true.obs).toList();
                    return  ItemServiceInHistory(
                      index: index,
                      service: serviceController.responseHistory.value?.data?.history?[index],
                    );
                  }
                )
              ),
            ]
          ),
        );
      }
    );
  }
}
