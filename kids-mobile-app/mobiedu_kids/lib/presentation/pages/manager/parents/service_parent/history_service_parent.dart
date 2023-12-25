import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class HistoryServiceParent extends StatelessWidget{
  HistoryServiceParent({
    super.key,
    required this.tabs
  });

  final String tabs;

  final serviceController = Get.find<ServiceParentController>();
  final currencyFormat = getCurrencyFormatVN();
  
  @override
  Widget build(BuildContext context) {
    serviceController.tabs.value = tabs;
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: serviceController,
      builder: (_) {
        return serviceController.isLoadingHistory.value
        ? const SizedBox(
            child: Center(
              child: CircularLoadingIndicator(),
            ),
          )
        :
        Container(
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
                    onTap: () async {
                      final picked = await showDateRangePicker(
                        context: Get.context!,
                        initialEntryMode: DatePickerEntryMode.input,
                        initialDateRange: DateTimeRange(
                          start: serviceController.firstDate,
                          end: serviceController.lastDate,
                        ),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (picked != null) {
                        serviceController.firstDate = picked.start;
                        serviceController.lastDate = picked.end;
                        serviceController.getHistory();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGrey
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(convertDateTimeToString(serviceController.firstDate),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Icon(
                            CupertinoIcons.arrow_right,
                            size: 16.0,
                            color: AppColors.grey,
                          ),
                          const SizedBox(width: 12.0),
                          Text(convertDateTimeToString(serviceController.lastDate),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              serviceController.responseHistory.value?.data?.history?.isNotEmpty ?? false ?
              Expanded(
                child: ListView.builder(
                  itemCount: serviceController.responseHistory.value?.data?.history?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.lightGrey
                          )
                        )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${index + 1}.', 
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${serviceController.responseHistory.value?.data?.history?[index].service_name}',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text('Phí theo số lần sử dụng',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4
                                  ),
                                ),
                              ),
                              Text('Giá: ${currencyFormat.format(int.parse(serviceController.responseHistory.value?.data?.history?[index].fee ?? '0'))}đ',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]
                      ),
                    );
                  }
                )
              )
          :   Expanded(
                child: SizedBox(
                  width: widthScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no_assig.png'
                      ),
                      const SizedBox(height: 8.0),
                      Text('Không có dữ liệu', 
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ]
          ),
        );
      }
    );
  }
}

