import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/search_api_controller/search_controller.dart';
import 'package:mooc_app/presentation/controllers/text_roadmap_controller.dart';
import 'package:mooc_app/presentation/pages/course_list/course_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mooc_app/presentation/pages/profile/roadmap/setting/roadmap_setting_3.dart';
import 'package:mooc_app/presentation/pages/profile/roadmap/setting/step_progress.dart';

import '../../../../widgets/course_item_2.dart';

class RoadmapSetting2 extends StatelessWidget {
  // static String routeName = "/search";
  RoadmapSetting2({super.key,required this.step,required this.title});
  final List<String> title;
  final int step;
  @override

  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final text = Get.put(TextRoadmapController());
    final search = Get.find<SearchFetchController>();
    return GestureDetector(onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
        child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              middle: CupertinoSearchTextField(
                placeholder: 'Tìm kiếm khóa học',
                autofocus: false,
                autocorrect: true,
                controller: text.search,
                onChanged: (String value) {},
                onSubmitted: (String value) {},
              ),
            ),
            child: Container(
                margin: EdgeInsets.only(top: CupertinoNavigationBar().preferredSize.height + statusBarHeight + 10),
                child: Flex(direction: Axis.vertical, children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: widthScreen/6,right: widthScreen/6),
                          child: StepProgressView(
                              width: widthScreen * 2 / 3,
                              curStep: step,
                              activeColor: Colors.blue,
                              titles: title),
                        ),
                        Container(
                          // margin: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tiêu đề",
                                  style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: CupertinoTextField(
                            placeholder: "Nhập nội dung tiêu đề",
                            // decoration: InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     hintText: "Nhập code tích điểm nếu có"
                            //   // labelText: 'Full Name',
                            // ),
                            controller: text.title,
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Khóa học",
                                  style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Container(
                          child: Flexible(
                              child: text.search.text != ""
                                  ? (search.search3.value!.items.length > 0 && search.search3.value!.items.length != null) ? ListView.builder(
                                  padding: EdgeInsets.only(),
                                  physics: ScrollPhysics(
                                      parent: ClampingScrollPhysics()),
                                  // padding: const EdgeInsets.only(left: 20, right: 20),
                                  itemCount: search.search3.value!.items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin: EdgeInsets.all(10),
                                        child: CourseItem2(
                                          widthItem: widthScreen,courseItem: search.search3.value!.items[index],));
                                  }) : Center(child: Container(child: Text("Không có khóa học nào"),),)
                                  : Container(
                                  child: Text("Không có khóa học nào"))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 88.0,
                      child: Flex(
                        children: [
                          Expanded(
                              child: Container(
                                  color: Colors.grey,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: widthScreen / 6,
                                          right: widthScreen / 6),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            // style: ElevatedButton.styleFrom(
                                            //   minimumSize: Size.fromHeight(10),
                                            // ),
                                              onPressed: () { Get.back(); },
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: FittedBox(
                                                    child: Text("Quay lại"),
                                                  ))),
                                          ElevatedButton(
                                            // style: ElevatedButton.styleFrom(
                                            //   minimumSize: Size.fromHeight(10),
                                            // ),
                                              onPressed: () { Get.to(() => RoadmapSetting3(step: 3,title: ["", "", "Bước 3/3"])); },
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: FittedBox(
                                                    child: Text("Tiếp tục"),
                                                  )))
                                        ],
                                      ))))
                        ],
                        direction: Axis.vertical,
                      ))
                ]))));
  }
}