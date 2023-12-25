import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/service_parent/history_service_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/service_parent/using_service_parent.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ServiceParent extends StatelessWidget {
  ServiceParent({super.key});

  final serviceParentController = Get.find<ServiceParentController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: serviceParentController,
      initState: (state) async {
        await serviceParentController.fetchData();
        await serviceParentController.getHistory();
      },
      builder: (_) {
        return Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 19.0),
              leading: GestureDetector(
                onTap: () {
                  final initPageTabController = Get.put(InitPageTabController());
                  initPageTabController.changeIndexTab(1);
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
                'Dịch vụ',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: (serviceParentController.isLoading.value || serviceParentController.isLoading.value)
            ? SizedBox(
                width: widthScreen,
                child: const Center(
                  child: CircularLoadingIndicator(),
                ),
              )
            :
            Container(
                margin: const EdgeInsets.only(top: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: DefaultTabController(
                  length: 2,
                  child: Column(children: [
                    Container(
                      height: 36,
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
                          color: AppColors.lightPink,
                        ),
                        tabs: const [
                          Tab(
                            child: Text('Sử dụng dịch vụ'),
                          ),
                          Tab(
                            child: Text('Lịch sử sử dụng'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          UsingServiceParent(tabs: 'using-service',),
                          HistoryServiceParent(tabs: 'history-service',),
                        ]
                      )
                    )
                  ]
                ),
              )
            ),
          )
        );
      }
    );
  }
}
