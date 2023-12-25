import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/widget/item_tuition.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class TuitionPage extends StatelessWidget {
  TuitionPage({super.key});
  final tuitionsController = Get.find<TuitionsController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return GetX(
      init: tuitionsController,
      initState: (state) async {
        await tuitionsController.responsetuitions();
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) { 
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
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
              'Học phí',
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
          child: tuitionsController.isLoading.value
          ? SizedBox(
              width: widthScreen,
              child: const Center(
                child: CircularLoadingIndicator(),
              ),
            )
          :
          tuitionsController.tuitionsData.isNotEmpty ?
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ListView.builder(
                itemCount: tuitionsController.tuitionsData.length,
                itemBuilder: (context, index) =>
                  ItemTuition(tuition: tuitionsController.tuitionsData[index])
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
            )
        );
      }
    );
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      await tuitionsController.loadMore();
    }
  }
}
