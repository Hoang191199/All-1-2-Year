import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class AssignmentShuttle extends StatelessWidget {
  AssignmentShuttle({super.key});

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: shuttleController,
      initState: (state) async {
        await shuttleController.assign();
      },
      builder: (_) { 
        return Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 19.0),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 70.0,
                  color: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Lịch được phân công',
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
            child: shuttleController.isLoadingListAssign.value
          ? const SizedBox(
              child: Center(
                child: CircularLoadingIndicator(),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: 36.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1, 
                        color: const Color(0xffffdff1)
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: TabBar(
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.primary,
                      labelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      unselectedLabelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: const Color(0xFFFFF4FA),
                      ),
                      tabs: const [
                        Tab(
                          child: Text('Tuần này', 
                          ),
                        ),
                        Tab(
                          child: Text('Tuần sau', 
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        shuttleController.calculateLength(shuttleController.responseListAssign.value?.data?.this_week) != 0 ?
                        Container(
                          margin: const EdgeInsets.only(top: 20.0,),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: shuttleController.calculateLength(shuttleController.responseListAssign.value?.data?.this_week),
                                  itemBuilder: (context, index) {
                                    List<String> daysOfWeek = [];
                                    List<String> assignDay = [];
                                    List<String> assignClass = [];
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.hai?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.hai?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Hai');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.ba?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.ba?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Ba');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.bon?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.bon?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Tư');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.nam?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.nam?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Năm');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.sau?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.sau?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Sáu');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.bay?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.bay?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Bảy');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.this_week?.cn?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.this_week?.cn?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('CN');
                                    }
                                    String dayOfWeek = daysOfWeek[index];
                                  return Container(
                                      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.lightGrey
                                          )
                                        )
                                      ),
                                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(dayOfWeek == "CN" ? dayOfWeek : 'Thứ $dayOfWeek', 
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                                height: 1.6
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [ Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Lớp: ${assignClass[index]}',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(
                                                      color: AppColors.grey,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                                Text('Phân công ngày: ${assignDay[index]}',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(
                                                      color: AppColors.grey,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ],
                                      )
                                    );
                                  } 
                                )
                              )
                            ],
                          )
                        )
                      : SizedBox(
                          width: widthScreen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/no_assig.png'
                              ),
                              const SizedBox(height: 8.0),
                              Text('Bạn chưa được phân công vào tuần này!', 
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
                      shuttleController.calculateLength(shuttleController.responseListAssign.value?.data?.next_week) != 0 ?
                        Container(
                          margin: const EdgeInsets.only(top: 20.0,),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: shuttleController.calculateLength(shuttleController.responseListAssign.value?.data?.next_week),
                                  itemBuilder: (context, index) {
                                    List<String> daysOfWeek = [];
                                    List<String> assignDay = [];
                                    List<String> assignClass = [];
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.hai?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.hai?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Hai');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.ba?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.ba?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Ba');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.bon?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.bon?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Tư');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.nam?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.nam?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Năm');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.sau?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.sau?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Sáu');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.bay?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.bay?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('Bảy');
                                    }
                                    if(shuttleController.responseListAssign.value?.data?.next_week?.cn?.first != null){
                                      var first = shuttleController.responseListAssign.value?.data?.next_week?.cn?.first;
                                      assignDay.add(first?.assign_time ?? '');
                                      assignClass.add(first?.class_name ?? '');
                                      daysOfWeek.add('CN');
                                    }
                                    String dayOfWeek = daysOfWeek[index];
                                  return Container(
                                      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.lightGrey
                                          )
                                        )
                                      ),
                                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(dayOfWeek == "CN" ? dayOfWeek : 'Thứ $dayOfWeek', 
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                                height: 1.6
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [ Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Lớp: ${assignClass[index]}',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(
                                                      color: AppColors.grey,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                                Text('Phân công ngày: ${assignDay[index]}',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(
                                                      color: AppColors.grey,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ],
                                      )
                                    );
                                  } 
                                )
                              )
                            ],
                          )
                        )
                      : SizedBox(
                          width: widthScreen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/no_assig.png'
                              ),
                              const SizedBox(height: 8.0),
                              Text('Bạn chưa được phân công vào tuần sau!', 
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            )
          )
        );
      }
    ); 
  }
}
