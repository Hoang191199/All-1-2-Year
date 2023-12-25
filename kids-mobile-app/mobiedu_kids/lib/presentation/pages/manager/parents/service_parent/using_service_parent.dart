import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child_service.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/service_parent/widget/show_date_service.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class UsingServiceParent extends StatelessWidget{
  UsingServiceParent({
    super.key,
    required this.tabs
  });

  final String tabs;

  final serviceController = Get.find<ServiceParentController>();
  final currencyFormat = getCurrencyFormatVN();
  
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    serviceController.tabs.value = tabs;

    return GetX(
      init: serviceController,
      builder: (_) {
        var serviceTemp = List<ItemChildService>.from(serviceController.listItemSerivce);
        
        return serviceController.isLoading.value
        ? const Center(
          child: CircularLoadingIndicator(),
        )
        :
        Container(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            children: [
              Column(
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
                            builder: (BuildContext context) => ShowDateParent()
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
                ],
              ),
              serviceTemp.isNotEmpty ?
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: serviceTemp.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
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
                                        Text('${serviceTemp[index].service_name}',
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
                                        Text('Giá: ${currencyFormat.format(int.parse(serviceTemp[index].fee ?? '0'))}đ',
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
                                  ],
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.green,
                                  value: serviceTemp[index].check_status,
                                  onChanged: (bool? value) {
                                    if(serviceTemp[index].checkClick == false) {
                                      serviceTemp[index].check_status = value!;
                                      serviceController.listItemSerivce.value = serviceTemp;
                                    }
                                  },
                                ),
                              ]
                            ),
                          );
                        }
                      )
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: widthScreen,
                          padding: EdgeInsets.only(bottom: bottomPadding + 10.0),
                          child: CupertinoButton(
                            onPressed: () {
                              serviceController.registerService();
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
                        ),
                      ),
                    )
                  ],
                ),
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
              )
            ]
          ),
        );
      }
    );
  }
}

