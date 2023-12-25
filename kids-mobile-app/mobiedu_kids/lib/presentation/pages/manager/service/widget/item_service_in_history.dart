import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/domain/entities/service/service_in_history.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';

class ItemServiceInHistory extends StatelessWidget {
  ItemServiceInHistory({
    super.key, 
    required this.index,
    this.service
  });

  final int index;
  final serviceController = Get.find<ServiceController>();
  final ServiceInHistory? service;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              serviceController.toggleShow(index);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        width: 36.0,
                        height: 36.0 ,           
                        number[index].icon,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          '${service?.service_name} (${service?.usage_count})',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                    ],
                  ),
                ),
                Obx(
                  () => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstChild: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30.0,
                      color: AppColors.primary,
                    ),
                    secondChild: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.0,
                      color: AppColors.primary,
                    ),
                    crossFadeState: serviceController.isShow[index].value? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                )
              ],
            ),
          ),
          Obx(() => 
            Visibility(
              visible: serviceController.isShow[index].value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  service?.children?.length ?? 0,
                  (index) => Container(
                    width: widthScreen,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppColors.lightGrey,
                    ))),
                    child: Text(
                      '${index + 1}. ${service!.children![index].child_name}',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ),
          )
        ]
      )
    );
  }
}


List<Number> number = [
  Number(icon: 'assets/images/number-1.png'),
  Number(icon: 'assets/images/number-2.png'),
  Number(icon: 'assets/images/number-3.png'),
  Number(icon: 'assets/images/number-4.png'),
  Number(icon: 'assets/images/number-5.png'),
  Number(icon: 'assets/images/number-6.png'),
  Number(icon: 'assets/images/number-7.png'),
  Number(icon: 'assets/images/number-8.png'),
  Number(icon: 'assets/images/number-9.png'),
  Number(icon: 'assets/images/number-10.png'),
  Number(icon: 'assets/images/number-11.png'),
  Number(icon: 'assets/images/number-12.png'),
];

class Number {
  String icon;
  Number({required this.icon});
}
