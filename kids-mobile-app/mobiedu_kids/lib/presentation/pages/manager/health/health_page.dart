import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/health/health_note_specific_page.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class HealthPage extends StatelessWidget {
  HealthPage({super.key, this.child_id});

  final String? child_id;

  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return GetX(
      init: growthController,
      initState: (state) async {
        growthController.fetch(store.getGroupname, child_id ?? "");
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Sức khỏe',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: growthController.listGrowth.isEmpty ? 
            const NoData() : 
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: (widthScreen - 56.0) / 5,
                        height: 50,
                      ),
                      Container(
                        width: (widthScreen - 56.0) / 5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                          border:Border.all(
                            color: AppColors.grey2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Chiều cao",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            Text(
                              "(cm)",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
                      ),
                      Container(
                        width: (widthScreen - 56.0) / 5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                          border:Border.all(
                            color: AppColors.grey2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cân nặng",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            Text(
                              "(kg)",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Container(
                        width: (widthScreen - 56.0) * 4 / 15,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                          border:Border.all(
                            color: AppColors.grey2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Thời gian",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(
                        width: (widthScreen - 56.0) * 2 / 15,
                        height: 50
                      )
                    ],
                  )
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => Row(
                      children: [
                        Container(
                          width: (widthScreen - 56.0) / 5,
                          height: (widthScreen - 56.0) / 5,
                          decoration: BoxDecoration(
                            color: AppColors.lightPink,
                            border: Border.all(
                              color: AppColors.grey2
                            )
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightPink,
                                  borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: growthController.listGrowth[index]?.source_file != null && growthController.listGrowth[index]?.source_file != ""? 
                                Image(
                                  height: ((widthScreen - 56.0) / 5) -10,
                                  width: ((widthScreen - 56.0) / 5) - 10,
                                  image: CachedNetworkImageProvider(
                                    "${growthController.listGrowth[index]?.source_file}",
                                  ),
                                  fit: BoxFit.cover
                                ) : 
                                Image(
                                  height: ((widthScreen - 56.0) / 5) - 10,
                                  width: ((widthScreen - 56.0) / 5) - 10,
                                  image: const AssetImage("assets/images/avatar-mac-dinh.png"),
                                  fit: BoxFit.cover
                                ),
                              )
                            ]
                          )
                        ),
                        Container(
                          width: (widthScreen - 56.0) / 5,
                          height: (widthScreen - 56.0) / 5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey2
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${growthController.listGrowth[index]?.height}",
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight:
                                    FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                            width: (widthScreen - 56.0) / 5,
                            height: (widthScreen - 56.0) / 5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey2
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${growthController.listGrowth[index]?.weight}",
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight:FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          width: (widthScreen - 56.0) * 4 / 15,
                          height: (widthScreen - 56.0) / 5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey2
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${growthController.listGrowth[index]?.recorded_at}",
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          width: (widthScreen - 56.0) * 2 / 15,
                          height: (widthScreen - 56.0) / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ChildBinding().dependencies();
                                  Get.to(() => HealthNoteSpecificPage(
                                      child_id:child_id,
                                      ind: index
                                    )
                                  );
                                },
                                child: Image(
                                  height: (((widthScreen - 56.0) / 5) - 10) / 2,
                                  width: (((widthScreen - 56.0) / 5) - 10) / 2,
                                  image: const AssetImage("assets/images/edit.png"),
                                  fit: BoxFit.cover
                                )
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(
                                    context,
                                    child_id ?? "",
                                    "${growthController.listGrowth[index]?.child_growth_id}"
                                  );
                                },
                                child: Image(
                                  height: (((widthScreen - 56.0) / 5) - 10) / 2,
                                  width: (((widthScreen - 56.0) / 5) - 10) / 2,
                                  image: const AssetImage(
                                      "assets/images/cancel.png"),
                                  fit: BoxFit.cover
                                ),
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                      const SizedBox(),
                    itemCount: growthController.listGrowth.length
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }

  void _showAlertDialog( BuildContext context, String child_id, String child_growth_id) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Xóa'),
        content: Text('Bạn có chắc chắn muốn xóa ?',
          style: TextStyle(color: AppColors.black)
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy', 
              style: TextStyle(
                color: AppColors.primaryBlue
              )
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              await growthController.delete(store.getGroupname, child_id, child_growth_id);
              await growthController.fetch(store.getGroupname, child_id);
              Navigator.pop(context);
            },
            child: Text(
              'Ok',
              style: TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }
}
