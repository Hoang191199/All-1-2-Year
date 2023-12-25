// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:get/get.dart';
// import 'package:mooc_app/domain/entities/paid_course.dart';
// import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
// import 'package:mooc_app/presentation/controllers/category/category_controller.dart';
// import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
// import 'package:mooc_app/presentation/controllers/search_api_controller/fetch_scroll_controller.dart';
// import 'package:mooc_app/presentation/controllers/search_api_controller/search_controller.dart';
// import 'package:mooc_app/presentation/pages/learning/history/history.dart';
// import 'package:mooc_app/presentation/pages/search/search_page.dart';
// import 'package:mooc_app/presentation/widgets/login_button.dart';
// import 'package:mooc_app/presentation/widgets/paid_course.dart';
// import '../../controllers/course_list/course_list_binding.dart';
// import '../../controllers/search_api_controller/fetch_controller.dart';
// import '../../controllers/tab_controller.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui' as ui;
//
// import '../../controllers/text_main_controller.dart';
// import '../../widgets/course_item.dart';
// import '../../widgets/course_item_2.dart';
// import '../../widgets/list_category.dart';
// import '../course_list/course_list_page.dart';
// import 'card/learning_card.dart';
//
// class LearningPage extends GetView<AuthController> {
//   // static String routeName = "/learning";
//   const LearningPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // final txt = Get.put(TextMainController());
//     // final tabx = Get.put(TabBarController());
//     final auth = Get.find<AuthController>();
//     final cate = Get.find<CategoryController>();
//     // final search = Get.find<SearchFetchController>();
//     // final fetch = Get.find<FetchController>();
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     double bottomBarHeight = MediaQuery.of(context).padding.bottom;
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;
//     final scroll = Get.put(ScrollingCourseController(
//         height: heightScreen - kBottomNavigationBarHeight -
//             CupertinoNavigationBar().preferredSize.height -
//             statusBarHeight));
//     return GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         child: Obx(() => Container(
//             child: auth.isLoggedIn.value
//                 ? CupertinoPageScaffold(
//               navigationBar: const CupertinoNavigationBar(
//                 automaticallyImplyLeading: false,
//                 middle: Text('Vào học'),
//               ),
//               child: (scroll.isloading.value != true && scroll.paging.value != null) ? (scroll.listMoocCourse.value.length != null &&
//                   scroll.listMoocCourse.value.isNotEmpty)
//                   ?
//               ListView.builder(
//                   physics: ClampingScrollPhysics(),
//                   padding: EdgeInsets.only(top: CupertinoNavigationBar().preferredSize.height + statusBarHeight,bottom: bottomBarHeight),
//                   itemCount:
//                   scroll.listMoocCourse.value.length,
//                   controller: scroll.scrollController,
//                   itemBuilder:
//                       (BuildContext context, int index) {
//                     return Container(
//                         margin: EdgeInsets.only(
//                             left: 20,
//                             right: 20,
//                             top: 10,
//                             bottom: 10),
//                         child: CoursePaid(
//                           widthItem: widthScreen,
//                           courseItem: scroll.listMoocCourse.value[index],
//                         ));
//                   })
//                   : Center(
//                   child: Container(
//                     child: Text("Không có khóa học nào"),
//                   )) : Container(child: Center(child: CircularProgressIndicator(),),) ,)
//             // MaterialApp(
//             //         theme: ThemeData(
//             //           cupertinoOverrideTheme:
//             //               const CupertinoThemeData(brightness: Brightness.dark),
//             //           primarySwatch: MaterialColor(0x99FFEEEEEE, <int, Color>{
//             //             50: Color(0xFFFAFAFA),
//             //             100: Color(0xFFF5F5F5),
//             //             200: Color(0xFFEEEEEE),
//             //             300: Color(0xFFE0E0E0),
//             //             400: Color(0xFFBDBDBD),
//             //             500: Color(0xFF9E9E9E),
//             //             600: Color(0xFF757575),
//             //             700: Color(0xFF616161),
//             //             800: Color(0xFF424242),
//             //             900: Color(0xFF212121),
//             //           }),
//             //         ),
//             //         home: Scaffold(
//             //           resizeToAvoidBottomInset: false,
//             //           appBar: PreferredSize(
//             //             preferredSize: Size.fromHeight(75.0),
//             //             child: AppBar(
//             //               toolbarHeight: 50,
//             //               title: auth.isLoggedIn.value == false ? Text("Vào học") : (tabx.index.value == 0 ? Text("Khóa học trọn đời", style: TextStyle(fontSize: 17),) : tabx.index.value == 1 ? Text("Thẻ học", style: TextStyle(fontSize: 17)) : Text("Học trải nghiệm", style: TextStyle(fontSize: 17))),
//             //               centerTitle: true,
//             //               bottom: TabBar(
//             //                 isScrollable: true,
//             //                 tabs: tabx.myTabs,
//             //                 controller: tabx.controller,
//             //                 onTap: (value) {
//             //                   tabx.index.value = value;
//             //                 },
//             //               ),
//             //               actions: [
//             //                 IconButton(
//             //                     onPressed: () {
//             //                       Get.to(() => SearchPage());
//             //                     },
//             //                     icon: Icon(CupertinoIcons.search,size: 17,))
//             //               ],
//             //             ),
//             //           ),
//             //           body:
//             //           tabx.myTabs.isNotEmpty
//             //               ? TabBarView(controller: tabx.controller, children: [
//             //                   fetch.isInitialized.value != true ? Center(
//             //                       child: Container(
//             //                         child: CircularProgressIndicator(),
//             //                       )) :
//             //                   (fetch.fetch.value?.length != null &&
//             //                       fetch.fetch.value!.length > 0)
//             //                       ? ListView.builder(
//             //                           padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
//             //                           itemCount:
//             //                              fetch.fetch.value?.length,
//             //                           itemBuilder:
//             //                               (BuildContext context, int index) {
//             //                             return Container(
//             //                                 margin: EdgeInsets.only(
//             //                                     left: 20,
//             //                                     right: 20,
//             //                                     top: 10,
//             //                                     bottom: 10),
//             //                                 child: CoursePaid(
//             //                                   widthItem: widthScreen,
//             //                                   courseItem: fetch.fetch.value?[index],
//             //                                 ));
//             //                           })
//             //                       : Center(
//             //                           child: Container(
//             //                           child: Text("Không có khóa học nào"),
//             //                         )) ,
//             //                   ListView.builder(
//             //                       padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
//             //                       itemCount: 9,
//             //                       itemBuilder:
//             //                           (BuildContext context, int index) {
//             //                         return Container(
//             //                             margin: EdgeInsets.only(
//             //                                 left: 20,
//             //                                 right: 20,
//             //                                 top: 10,
//             //                                 bottom: 10),
//             //                             child: LearningCard(
//             //                               index: index,
//             //                             ));
//             //                       }),
//             //                   Column(children: [
//             //                     Container(
//             //                         margin: EdgeInsets.all(20),
//             //                         child: TextField(
//             //                           decoration: InputDecoration(
//             //                               border: OutlineInputBorder(),
//             //                               hintText: "Nhập code tích điểm nếu có"
//             //                               // labelText: 'Full Name',
//             //                               ),
//             //                           controller: txt.pointcode,
//             //                         )),
//             //                     txt.pointcode.text != ""
//             //                         ? Container(
//             //                             margin: EdgeInsets.only(
//             //                                 left: widthScreen / 20,
//             //                                 right: widthScreen / 20),
//             //                             child: ElevatedButton(
//             //                               style: ElevatedButton.styleFrom(
//             //                                 minimumSize: Size.fromHeight(40),
//             //                                 backgroundColor: Colors.green,
//             //                               ),
//             //                               child: FittedBox(
//             //                                   child: Row(children: [
//             //                                 Text(
//             //                                   "Nhập code",
//             //                                   style: TextStyle(
//             //                                       fontSize: 20,
//             //                                       color: Colors.white),
//             //                                 ),
//             //                               ])),
//             //                               onPressed: () {
//             //                                 Get.back();
//             //                               },
//             //                             ))
//             //                         : Container(),
//             //                     Container(
//             //                       margin: EdgeInsets.only(left: 20, right: 20),
//             //                       child: RichText(
//             //                         text: TextSpan(children: [
//             //                           WidgetSpan(
//             //                             alignment:
//             //                                 ui.PlaceholderAlignment.middle,
//             //                             child: Icon(CupertinoIcons
//             //                                 .check_mark_circled_solid),
//             //                           ),
//             //                           TextSpan(
//             //                               style: TextStyle(
//             //                                   color: Colors.black,
//             //                                   fontSize: 16),
//             //                               text:
//             //                                   "Sử dụng Điểm thưởng tích lũy để học miễn phí 30 ngày các khóa học mới ra mắt trên Unica"),
//             //                         ]),
//             //                       ),
//             //                     ),
//             //                     Container(
//             //                         margin:
//             //                             EdgeInsets.only(left: 20, right: 20),
//             //                         child: RichText(
//             //                             text: TextSpan(children: [
//             //                           WidgetSpan(
//             //                             alignment:
//             //                                 ui.PlaceholderAlignment.middle,
//             //                             child: Icon(CupertinoIcons
//             //                                 .check_mark_circled_solid),
//             //                           ),
//             //                           TextSpan(
//             //                             text: "Bấm vào ",
//             //                             style: TextStyle(
//             //                                 color: Colors.black, fontSize: 16),
//             //                           ),
//             //                           TextSpan(
//             //                             text: "ĐÂY",
//             //                             style: TextStyle(
//             //                                 color: Colors.black, fontSize: 16),
//             //                             recognizer: TapGestureRecognizer()
//             //                               ..onTap =
//             //                                   () => dialogSupport(context),
//             //                           ),
//             //                           TextSpan(
//             //                             text:
//             //                                 " để xem các hướng dẫn các cách tăng điểm",
//             //                             style: TextStyle(
//             //                                 color: Colors.black, fontSize: 16),
//             //                           ),
//             //                         ]))),
//             //                     Container(
//             //                       margin: EdgeInsets.only(left: 20, right: 20),
//             //                       child: RichText(
//             //                         text: TextSpan(
//             //                           children: [
//             //                             WidgetSpan(
//             //                               alignment:
//             //                                   ui.PlaceholderAlignment.middle,
//             //                               child: Icon(CupertinoIcons
//             //                                   .check_mark_circled_solid),
//             //                             ),
//             //                             TextSpan(
//             //                               text:
//             //                                   "Tổng số điểm của bạn hiện đang là ",
//             //                               style: TextStyle(
//             //                                   color: Colors.black,
//             //                                   fontSize: 16),
//             //                             ),
//             //                             TextSpan(
//             //                               text: "[LỊCH SỬ ĐIỂM]",
//             //                               style: TextStyle(
//             //                                   color: Colors.black,
//             //                                   fontSize: 16),
//             //                               recognizer: TapGestureRecognizer()
//             //                                 ..onTap = () {
//             //                                     CourseDetailBinding().dependencies();
//             //                                     Get.to(() => HistoryPage());},
//             //                             ),
//             //                           ],
//             //                         ),
//             //                       ),
//             //                     ),
//             //                     Container(
//             //                       //modified
//             //                       margin: EdgeInsets.all(20),
//             //                       child: Row(
//             //                         crossAxisAlignment:
//             //                             CrossAxisAlignment.center,
//             //                         children: [
//             //                           Expanded(
//             //                             child: TextField(
//             //                               controller: txt.searchcourse,
//             //                               onSubmitted: ((value) =>
//             //                                   search.fetchData2(value)),
//             //                               decoration: InputDecoration(
//             //                                   hintText: "Tìm kiếm khóa học",
//             //                                   fillColor: Colors.grey,
//             //                                   filled: true,
//             //                                   border: InputBorder.none),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             margin: EdgeInsets.symmetric(
//             //                                 horizontal: 4.0),
//             //                             decoration: BoxDecoration(
//             //                               borderRadius:
//             //                                   BorderRadius.circular(8.0),
//             //                               color: Colors.grey.withOpacity(0.5),
//             //                             ),
//             //                             child: IconButton(
//             //                                 icon: Icon(CupertinoIcons.search,
//             //                                     color: Colors.white),
//             //                                 onPressed: () {
//             //                                   search.fetchData2(
//             //                                       "${txt.searchcourse.text}");
//             //                                 }),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     Flexible(
//             //                         child: search.search2.value?.items.length !=
//             //                                     null &&
//             //                                 search.search2.value!.items!
//             //                                         .length >
//             //                                     0
//             //                             ? ListView.builder(
//             //                                 padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
//             //                                 itemCount: search
//             //                                     .search2.value!.items.length,
//             //                                 itemBuilder: (BuildContext context,
//             //                                     int index) {
//             //                                   return Container(
//             //                                       margin: EdgeInsets.all(20),
//             //                                       child: CourseItem2(
//             //                                         widthItem: widthScreen,
//             //                                         courseItem: search.search2
//             //                                             .value!.items[index],
//             //                                       ));
//             //                                 })
//             //                             : Container(
//             //                                 child: Text(
//             //                                     "Không có khóa học nào cho ${txt.searchcourse.text}"),
//             //                               ))
//             //                   ])
//             //                 ])
//             //               : Center(
//             //                   child: Image.asset(
//             //                     'assets/images/logo.png',
//             //                   ),
//             //                 ),
//             //         )
//             // )
//                 : CupertinoPageScaffold(
//               navigationBar: const CupertinoNavigationBar(
//                 automaticallyImplyLeading: false,
//                 middle: Text('Vào học'),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     top: statusBarHeight +
//                         CupertinoNavigationBar().preferredSize.height),
//                 child: Column(children: [
//                   Container(
//                     height: heightScreen -
//                         CupertinoNavigationBar().preferredSize.height -
//                         kBottomNavigationBarHeight -
//                         70,
//                     child: SingleChildScrollView(
//                       physics: ClampingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           Container(
//                             child: Image.asset(
//                               'assets/images/video.jpg',
//                               width: widthScreen / 2,
//                               height: heightScreen / 4,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 20.0, left: 10),
//                             child: Center(
//                               child: Text(
//                                   "Chia sẻ kiến thức và kinh ngiệm thực tế đến hàng triệu người",
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w600)),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 20.0, left: 10),
//                             child: Center(
//                               child: Text(
//                                 "Học bất cứ lúc nào bất cứ nơi đâu",
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 20.0,left: 10),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Danh mục khóa học",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.w600)),
//                               ],
//                             ),
//                           ),
//                           ListCategory(length: cate.categoryResponse.value?.items?.length,cate: cate.categoryResponse.value?.items,)
//                           // ListView.separated(
//                           //     padding: EdgeInsets.only(top: 0),
//                           //     physics: NeverScrollableScrollPhysics(),
//                           //     shrinkWrap: true,
//                           //     itemCount: cate.categoriesData.length,
//                           //     itemBuilder: (context, index) {
//                           //       return
//                           //       //   OutlinedButton(onPressed: () {},style: OutlinedButton.styleFrom(
//                           //       // side: BorderSide(
//                           //       // width: 1.0,
//                           //       // color: Colors.black12,
//                           //       // style: BorderStyle.solid,
//                           //       // ),
//                           //       // ),child:
//                           //       CupertinoButton(
//                           //         pressedOpacity: 0.65,
//                           //         color: Colors.white,
//                           //         borderRadius: const BorderRadius.all(
//                           //           Radius.circular(0),
//                           //         ),
//                           //         padding: const EdgeInsets.symmetric(
//                           //             horizontal: 20, vertical: 16),
//                           //         alignment: Alignment.centerLeft,
//                           //         child: Row(
//                           //           mainAxisAlignment:
//                           //               MainAxisAlignment.spaceBetween,
//                           //           children: [
//                           //             Row(
//                           //               children: [
//                           //                 const Padding(
//                           //                   padding: EdgeInsets.only(
//                           //                       right: 12),
//                           //                   child: SizedBox(
//                           //                       height: 28,
//                           //                       width: 28,
//                           //                       child: Icon(
//                           //                         CupertinoIcons
//                           //                             .paperclip,
//                           //                         color: Colors.black,
//                           //                       )),
//                           //                 ),
//                           //                 Text(
//                           //                   "${cate.categoryResponse.value?.items?[index].label}",
//                           //                   style: TextStyle(
//                           //                       color: Colors.black),
//                           //                 ),
//                           //               ],
//                           //             ),
//                           //             // const Icon(
//                           //             //   CupertinoIcons.chevron_right,
//                           //             //   color: Colors.grey,
//                           //             // ),
//                           //           ],
//                           //         ),
//                           //         onPressed: () {
//                           //           CourseListBinding().dependencies();
//                           //           Get.to(() => CourseListPage(
//                           //               navigationBarTitle:
//                           //                   'Danh mục ${index}',
//                           //               category: '',
//                           //              keyword: '',
//                           //           ));
//                           //         },
//                           //       )
//                           //       // )
//                           //       ;
//                           //     }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 0.5,); },)
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Container(height: heightScreen*16/8,),
//                   Expanded(child: LoginButton())
//                 ]),
//               ),
//             ))));
//   }
// }
//
// // Future<void> dialogSupport(BuildContext context) {
// //   return showDialog<void>(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return Dialog(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Container(
// //                 margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
// //                 padding: const EdgeInsets.only(bottom: 10.0),
// //                 width: double.infinity,
// //                 decoration: const BoxDecoration(
// //                     border: Border(bottom: BorderSide(color: Colors.black12))),
// //                 child: Row(
// //                   children: [
// //                     const Expanded(
// //                       child: Padding(
// //                         padding: EdgeInsets.only(left: 42.0),
// //                         child: Text(
// //                           'Để nhận điểm thưởng',
// //                           style: TextStyle(
// //                               fontSize: 16.0, fontWeight: FontWeight.w700),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                         onTap: () => Navigator.pop(context),
// //                         child: Container(
// //                           margin: const EdgeInsets.only(right: 20.0),
// //                           child: const Icon(CupertinoIcons.clear,
// //                               size: 22.0, color: Colors.black54),
// //                         ))
// //                   ],
// //                 )),
// //             Container(
// //               margin: const EdgeInsets.all(20.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: const [
// //                       Icon(CupertinoIcons.check_mark, color: Colors.black54),
// //                       SizedBox(width: 6.0),
// //                       Text('Giới thiệu học viên mới',
// //                           style: TextStyle(fontWeight: FontWeight.w500)),
// //                     ],
// //                   ),
// //                   // Text('0999999999', style: TextStyle(color: Colors.lightBlue[800]))
// //                   IconButton(
// //                       onPressed: () async {
// //                         await Clipboard.setData(
// //                                 ClipboardData(text: "https://lmoocs.gov.la/"));
// //                         Get.snackbar(
// //                           "Thành công",
// //                           "Đã lưu vào clipboard",
// //                           icon: const Icon(CupertinoIcons.check_mark_circled,
// //                               color: Colors.white),
// //                           snackPosition: SnackPosition.TOP,
// //                           backgroundColor: Colors.green,
// //                           borderRadius: 10,
// //                           colorText: Colors.white,
// //                           duration: const Duration(seconds: 3),
// //                           isDismissible: true,
// //                           dismissDirection: DismissDirection.horizontal,
// //                           forwardAnimationCurve: Curves.easeOutBack,
// //                         );
// //
// //                       },
// //                       icon: Icon(CupertinoIcons.doc_on_clipboard))
// //                 ],
// //               ),
// //             ),
// //             Container(
// //               margin: const EdgeInsets.all(20.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: const [
// //                       Icon(CupertinoIcons.check_mark, color: Colors.black54),
// //                       SizedBox(width: 6.0),
// //                       Text('Đánh giá khóa học',
// //                           style: TextStyle(fontWeight: FontWeight.w500)),
// //                     ],
// //                   ),
// //                   Text(' + 2 điểm',
// //                       style: TextStyle(color: Colors.lightBlue[800]))
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 20.0)
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // }
//
// // Widget _listTileAlt(BuildContext context, int index, String text) {
// //   return CupertinoButton(
// //     pressedOpacity: 0.65,
// //     color: Colors.white,
// //     borderRadius: const BorderRadius.all(
// //       Radius.circular(0),
// //     ),
// //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //     alignment: Alignment.centerLeft,
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Row(
// //           children: [
// //             const Padding(
// //               padding: EdgeInsets.only(right: 12),
// //               child: SizedBox(
// //                   height: 28,
// //                   width: 28,
// //                   child: Icon(
// //                     CupertinoIcons.paperclip,
// //                     color: Colors.black,
// //                   )),
// //             ),
// //             Text(
// //               text,
// //               style: TextStyle(color: Colors.black),
// //             ),
// //           ],
// //         ),
// //         const Icon(
// //           CupertinoIcons.chevron_right,
// //           color: Colors.grey,
// //         ),
// //       ],
// //     ),
// //     onPressed: () {
// //       Get.to(() => CourseListPage(
// //             navigationBarTitle: 'Danh mục ${index}',
// //             category: '',
// //         keyword: '',
// //           ));
// //     },
// //   );
// // }
