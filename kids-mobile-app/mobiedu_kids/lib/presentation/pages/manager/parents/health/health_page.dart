import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/growths_details.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/health_note_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/health_note_specific_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HealthChildPage extends StatelessWidget {
  HealthChildPage({super.key, this.child_parent_id});

  final String? child_parent_id;

  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    int getMonth = ((DateTime.now().year - DateFormat("dd/MM/yyyy").parse(store.getChild?.birthday ?? "").year) * 12 + 
    (DateTime.now().month - DateFormat("dd/MM/yyyy").parse(store.getChild?.birthday ?? "").month) + 1);
    return GetX(
      init: growthController,
      initState: (state) async {
        await growthController.fetchChild(
          child_parent_id ?? "",
          "0",
          getMonth.toString()
        );
        growthController.startMonth.value = 0;
        growthController.endMonth.value = getMonth.toDouble();
      },
      builder: (state) {
        return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
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
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              trailing: Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => HealthNoteChildPage());
                  },
                  child: const Image(
                    height: 30,
                    width: 30,
                    image: AssetImage("assets/images/add_g.png"),
                    fit: BoxFit.cover
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
              child: Column(
                children: [
                  Text(
                    "Chọn tháng",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  RangeSlider(
                    labels: RangeLabels(
                      "${growthController.startMonth.value}",
                      "${growthController.endMonth.value}",
                    ),
                    min: 0,
                    max: getMonth.toDouble(),
                    divisions: getMonth,
                    values: RangeValues(
                      growthController.startMonth.value,
                      growthController.endMonth.value
                    ),
                    onChanged: (RangeValues value) async {
                      growthController.startMonth.value = value.start;
                      growthController.endMonth.value = value.end;
                      await growthController.fetchChild(
                        child_parent_id ?? "",
                        (growthController.startMonth.value.toInt()).toString(),
                        (growthController.endMonth.value.toInt()).toString()
                      );
                    },
                  ),
                  growthController.choiceIndex.value == 0 ? 
                  SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('dd/MM/yyyy'),
                      visibleMinimum: visibleDateTime(growthController.startMonth.value),
                      visibleMaximum: visibleDateTime(growthController.endMonth.value),
                    ),
                    series: <ChartSeries>[
                      LineSeries<GrowthsDetails?, DateTime>(
                        dataSource: growthController.listGrowth,
                        xValueMapper: (GrowthsDetails? x, _) {
                          return DateFormat("dd/MM/yyyy").parse(x?.recorded_at ?? "");
                        } ,
                        yValueMapper: (GrowthsDetails? y, _) {
                          return double.parse(y?.height ?? "0");
                        }
                      )
                    ]
                  ) : 
                  growthController.choiceIndex.value == 1 ? 
                  SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('dd/MM/yyyy'),
                      visibleMinimum: visibleDateTime(growthController.startMonth.value),
                      visibleMaximum: visibleDateTime(growthController.endMonth.value),
                      ),
                    series: <ChartSeries>[
                      LineSeries<GrowthsDetails?, DateTime>(
                        dataSource: growthController.listGrowth,
                        xValueMapper: (GrowthsDetails? x, _) {
                          return DateFormat("dd/MM/yyyy").parse(x?.recorded_at ?? "");
                        },
                        yValueMapper: (GrowthsDetails? y, _) {
                          return double.parse(y?.weight ?? "0");
                        }
                      )
                    ]
                  ) : 
                  SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('dd/MM/yyyy'),
                      visibleMinimum: visibleDateTime(growthController.startMonth.value),
                      visibleMaximum: visibleDateTime(growthController.endMonth.value), 
                    ),
                    series: <ChartSeries>[
                      LineSeries<GrowthsDetails?, DateTime>(
                        dataSource: growthController.listGrowth,
                        xValueMapper: (GrowthsDetails? x, _) {
                          return DateFormat("dd/MM/yyyy").parse(x?.recorded_at ?? "");
                        },
                        yValueMapper: (GrowthsDetails? y, _) {
                          return double.parse(y?.bmi ?? "0");
                        }
                      )
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: (widthScreen - 56) / 3 - 10,
                        child: CupertinoButton(
                          onPressed: () async {
                            growthController.choiceIndex.value = 0;
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: growthController.choiceIndex.value == 0 ? AppColors.pink : AppColors.grey,
                          child: Text(
                            'Chiều cao',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        )
                      ),
                      SizedBox(
                        width: (widthScreen - 56) / 3 - 10,
                        child: CupertinoButton(
                          onPressed: () async {
                            growthController.choiceIndex.value = 1;
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          borderRadius: BorderRadius.circular(10.0),
                            color: growthController.choiceIndex.value == 1 ? AppColors.pink : AppColors.grey,
                            child: Text(
                              'Cân nặng',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          )
                        ),
                        SizedBox(
                          width: (widthScreen - 56) / 3 - 10,
                          child: CupertinoButton(
                            onPressed: () async {
                              growthController.choiceIndex.value = 2;
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                            borderRadius: BorderRadius.circular(10.0),
                            color:  growthController.choiceIndex.value == 2 ? AppColors.pink : AppColors.grey,
                            child: Text(
                              'BMI',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          )
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: (widthScreen - 56.0) / 5,
                          ),
                          Container(
                            height: 50,
                            width: (widthScreen - 56.0) / 5,
                            decoration: BoxDecoration(
                              color: AppColors.lightPink,
                              border: Border.all(color: AppColors.grey2)
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
                                      fontWeight: FontWeight.w700
                                    ),
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
                              border: Border.all(color: AppColors.grey2)
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
                              border: Border.all(
                                color: AppColors.grey2)
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
                              border: Border.all(color: AppColors.grey2)
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:AppColors.lightPink,
                                    borderRadius:BorderRadius.circular(20.0)
                                  ),
                                  child: growthController.listGrowth[index]?.source_file != null && growthController.listGrowth[index]?.source_file != "" ? 
                                  Image(
                                    height: ((widthScreen -56.0) / 5) -10,
                                    width: ((widthScreen - 56.0) / 5) -10,
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
                              border: Border.all(color: AppColors.grey2)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${growthController.listGrowth[index]?.height}",
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
                            width: (widthScreen - 56.0) / 5,
                            height: (widthScreen - 56.0) / 5,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey2)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${growthController.listGrowth[index]?.weight}",
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
                            height: (widthScreen - 56.0) / 5,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey2)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${growthController.listGrowth[index]?.recorded_at}",
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight:  FontWeight.w700
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
                                    Get.to(() =>HealthNoteSpecificChildPage(ind: index));
                                  },
                                  child: Image(
                                    height: (((widthScreen - 56.0) / 5) - 10) / 2,
                                    width: (((widthScreen - 56.0) / 5) - 10) / 2,
                                    image: const AssetImage(
                                        "assets/images/edit.png"),
                                    fit: BoxFit.cover
                                  )
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showAlertDialog(context,
                                    "${growthController.listGrowth[index]?.child_growth_id}");
                                  },
                                  child: Image(
                                    height: (((widthScreen - 56.0) / 5) - 10) / 2,
                                    width: (((widthScreen - 56.0) / 5) -  10) / 2,
                                    image: const AssetImage( "assets/images/cancel.png"),
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
  );}
  DateTime visibleDateTime(double valueDateTime){
    return DateTime(DateFormat("dd/MM/yyyy").parse(store.getChild?.birthday ?? "").year,
      DateFormat("dd/MM/yyyy").parse(store.getChild?.birthday ?? "").month + valueDateTime.toInt(),
      DateFormat("dd/MM/yyyy").parse(store.getChild?.birthday ?? "").day);
  }



  void _showAlertDialog(BuildContext context, String child_growth_id) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Xóa'),
        content: Text('Bạn có chắc chắn muốn xóa ?',
            style: TextStyle(color: AppColors.black)),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy', style: TextStyle(color: AppColors.primaryBlue)),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              await growthController.deleteChild(
                  child_parent_id ?? "", child_growth_id);
              print({child_parent_id ?? "", child_growth_id});
              await growthController.fetchChild(
                  child_parent_id ?? "",
                  (growthController.startMonth.value.toInt()).toString(),
                  (growthController.endMonth.value.toInt()).toString());
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
