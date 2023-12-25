import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/tuition_parent/item_tuition_parent.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class TuitionParent extends StatelessWidget {
  TuitionParent({
    super.key
  });

  final tuitionsParentController = Get.find<TuitionsParentController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: tuitionsParentController,
      initState: (state) async {
        await tuitionsParentController.fetchData();
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
          child: tuitionsParentController.isLoading.value
          ? const SizedBox(
              child: Center(
                child: CircularLoadingIndicator(),
              ),
            )
            :
          tuitionsParentController.tuitionsData.isNotEmpty ?
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: ListView.builder(
              itemCount: tuitionsParentController.tuitionsData.length,
              itemBuilder: (context, index) => ItemTuitionParent(index: index)
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
          ),
        );
      }
    );
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      await tuitionsParentController.loadMore();
    }
  }
}