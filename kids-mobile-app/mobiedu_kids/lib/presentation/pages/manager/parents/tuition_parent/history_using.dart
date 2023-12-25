import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/item_tuition_for_student.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/table_tuition_for_student.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class HistoryUsing extends StatelessWidget{
  HistoryUsing({
    super.key,
    required this.id,
    required this.monthYear
  });

  final int id;
  final String monthYear;
  final tuitionsParentController = Get.find<TuitionsParentController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: tuitionsParentController,
      initState: (state) {
        tuitionsParentController.getDetail(id);
      },
      builder: (_) {
        return Scaffold(
          key: scaffoldKey,
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
                  child: Icon(CupertinoIcons.back,
                    color: AppColors.primary
                  ),
                ),
              ),
              middle: Text(
                'Lịch sử sử dụng',
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
            child: tuitionsParentController.isLoadingDetail.value ? 
              SizedBox(
                width: widthScreen,
                child: const Center(
                  child: CircularLoadingIndicator(),
                ),
              )
          : Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1, 
                          color: AppColors.lightGrey
                        )
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tháng: $monthYear",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Text(
                          tuitionsParentController.responseTuitionsItem.value?.data?.status == "0" ?"Chưa thanh toán" : "Đã thanh toán",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: tuitionsParentController.responseTuitionsItem.value?.data?.status == "0" ? AppColors.red : AppColors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                  tuitionsParentController.responseTuitionsItem.value?.data?.tuition_detail?.isNotEmpty ?? false ?
                  Flexible(
                    child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tuitionsParentController.responseTuitionsItem.value?.data?.tuition_detail?.length,
                    itemBuilder: (context, index) => ItemTuitionForStudent(
                      tuition_detail: tuitionsParentController.responseTuitionsItem.value?.data?.tuition_detail?[index],
                      index: index
                    ),
                    )
                  )
                  : const SizedBox(),
                  TableTuitionForStudent(data: tuitionsParentController.responseTuitionsItem.value?.data),
                  const SizedBox(height: 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin chuyển khoản:',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color:  AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        height: 200.0,
                        width: widthScreen,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/card-bank.png'),
                            fit: BoxFit.fill
                          )
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 20.0,
                              left: 20.0,
                              width: widthScreen - 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Số tài khoản',
                                    style: GoogleFonts.raleway(
                                      textStyle: const TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text('${tuitionsParentController.responseTuitionsItem.value?.data?.bank_account}',
                                          style: GoogleFonts.raleway(
                                            textStyle: const TextStyle(
                                              color:  Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      GestureDetector(
                                        onTap: () async  {
                                          await Clipboard.setData(ClipboardData(text: tuitionsParentController.responseTuitionsItem.value?.data?.bank_account ?? '')).then((_) {
                                            scaffoldKey.currentState?.showBottomSheet((context) => Container(
                                              alignment: Alignment.center,
                                              height: 70.0,
                                              width: widthScreen,
                                              child: const Text('Copy số tài khoản thành công'),
                                            ));
                                          });
                                          await Future.delayed(const Duration(seconds: 1), () {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text('Ấn để sao chép',
                                          style: GoogleFonts.raleway(
                                            textStyle: const TextStyle(
                                              color:  Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}