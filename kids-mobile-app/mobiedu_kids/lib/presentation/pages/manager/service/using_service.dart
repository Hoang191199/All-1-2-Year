import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/widget/item_studen.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/widget/show_date_now.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class UsingService extends StatelessWidget{
  UsingService({
    super.key,
    required this.tabs
  });

  final String tabs;

  final serviceController = Get.find<ServiceController>();
  
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    serviceController.tabs.value = 'using-service';

    return GetX(
      init: serviceController,
      builder: (_) { 
        return serviceController.isLoading.value ?
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
                          Text(convertDateTimeToString(serviceController.dateUsing), 
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
              const SizedBox(height: 16.0),
              serviceController.listItemChild.isNotEmpty ?
              Expanded(
                child: ListView.builder(
                  itemCount: serviceController.listItemChild.length,
                  itemBuilder: (context, index) => ItemStudent(
                    index: index,
                    data: serviceController.listItemChild[index]
                  )
                )
              )
            : Expanded(
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
              if(serviceController.listItemChild.isNotEmpty)
              Container(
                width: widthScreen,
                padding: EdgeInsets.only(top: 10.0, bottom: bottomPadding + 10.0),
                child: CupertinoButton(
                  onPressed: () {
                    serviceController.updateService();
                  },
                  padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                  color: AppColors.pink,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Text(
                    'Lưu',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        height: 1.5
                      ),
                    ),
                  ),
                )
              )
            ]
          ),
        );
      }
    );
  }
}

