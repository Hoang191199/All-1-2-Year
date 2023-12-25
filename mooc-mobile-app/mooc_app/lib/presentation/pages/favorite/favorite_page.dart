import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_binding.dart';
import 'package:mooc_app/presentation/widgets/list_category.dart';
import 'package:mooc_app/presentation/widgets/login_button.dart';
import '../../controllers/category/category_controller.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/search_api_controller/search_controller.dart';
import '../../widgets/course_item_2.dart';
import '../course_list/course_list_page.dart';

class FavoritePage extends GetView<AuthController> {
  // static String routeName = "/favorite";

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final loginController = Get.put(LoginController());
    final auth = Get.find<AuthController>();
    final cate = Get.find<CategoryController>();
    final search = Get.find<SearchFetchController>();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Yêu thích'),
        ),
        child: Obx(() => Container(
              // padding: EdgeInsets.only(top: statusBarHeight),
              child: auth.isLoggedIn.value
                  ? search.search3.value == null
                      ? Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : (search.search3.value!.items.length != null &&
                              search.search3.value!.items.isNotEmpty)
                          ? ListView.builder(
                              // padding: const EdgeInsets.only(left: 20, right: 20),
                              itemCount: search.search3.value!.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    // margin: EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: CourseItem2(
                                      widthItem: widthScreen,
                                      courseItem:
                                          search.search3.value!.items[index],
                                    ));
                              })
                          : Center(
                              child: Container(
                              child:
                                  const Text("Không có khóa học yêu thích nào"),
                            ))
                  : Padding(
                      padding: EdgeInsets.only(
                          top: statusBarHeight +
                              const CupertinoNavigationBar()
                                  .preferredSize
                                  .height),
                      child: Column(children: [
                        Container(
                          height: heightScreen -
                              const CupertinoNavigationBar()
                                  .preferredSize
                                  .height -
                              kBottomNavigationBarHeight -
                              70,
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/images/video.jpg',
                                    width: widthScreen / 2,
                                    height: heightScreen / 4,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20.0, left: 10),
                                  child: const Center(
                                    child: Text(
                                        "Chia sẻ kiến thức và kinh ngiệm thực tế đến hàng triệu người",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    // Container(
                                    //     margin: const EdgeInsets.only(right: 10.0),
                                    //     child: Row(
                                    //       children: [
                                    //         Text('Xem thêm',
                                    //             style: TextStyle(
                                    //                 fontSize: 14.0,
                                    //                 color: Colors.grey[600])),
                                    //         const SizedBox(width: 6.0),
                                    //         const Icon(
                                    //           CupertinoIcons.arrow_right,
                                    //           size: 14.0,
                                    //           color: Colors.black87,
                                    //         )
                                    //       ],
                                    //     )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20.0, left: 10),
                                  child: const Center(
                                    child: Text(
                                      "Học bất cứ lúc nào bất cứ nơi đâu",
                                      textAlign: TextAlign.center,
                                    ),
                                    // Container(
                                    //     margin: const EdgeInsets.only(right: 10.0),
                                    //     child: Row(
                                    //       children: [
                                    //         Text('Xem thêm',
                                    //             style: TextStyle(
                                    //                 fontSize: 14.0,
                                    //                 color: Colors.grey[600])),
                                    //         const SizedBox(width: 6.0),
                                    //         const Icon(
                                    //           CupertinoIcons.arrow_right,
                                    //           size: 14.0,
                                    //           color: Colors.black87,
                                    //         )
                                    //       ],
                                    //  ))
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20.0, left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Danh mục khóa học",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      // Container(
                                      //     margin: const EdgeInsets.only(right: 10.0),
                                      //     child: Row(
                                      //       children: [
                                      //         Text('Xem thêm',
                                      //             style: TextStyle(
                                      //                 fontSize: 14.0,
                                      //                 color: Colors.grey[600])),
                                      //         const SizedBox(width: 6.0),
                                      //         const Icon(
                                      //           CupertinoIcons.arrow_right,
                                      //           size: 14.0,
                                      //           color: Colors.black87,
                                      //         )
                                      //       ],
                                      //     )),
                                    ],
                                  ),
                                ),
                                ListCategory(
                                  length: cate.categoriesData.value.length,
                                  cate: cate.categoriesData.value,
                                )
                                // ListView.separated(
                                //     padding: const EdgeInsets.only(top: 0),
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     shrinkWrap: true,
                                //     itemCount: cate.categoriesData.length,
                                //     itemBuilder: (context, index) {
                                //       return
                                //       //   OutlinedButton(onPressed: () {},style: OutlinedButton.styleFrom(
                                //       // side: BorderSide(
                                //       // width: 1.0,
                                //       // color: Colors.black12,
                                //       // style: BorderStyle.solid,
                                //       // ),
                                //       // ),child:
                                //       CupertinoButton(
                                //         pressedOpacity: 0.65,
                                //         color: Colors.white,
                                //         borderRadius: const BorderRadius.all(
                                //           Radius.circular(0),
                                //         ),
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 20, vertical: 16),
                                //         alignment: Alignment.centerLeft,
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Row(
                                //               children: [
                                //                 const Padding(
                                //                   padding: EdgeInsets.only(
                                //                       right: 12),
                                //                   child: SizedBox(
                                //                       height: 28,
                                //                       width: 28,
                                //                       child: Icon(
                                //                         CupertinoIcons
                                //                             .paperclip,
                                //                         color: Colors.black,
                                //                       )),
                                //                 ),
                                //                 Text(
                                //                   "${cate.categoryResponse.value?.items?[index].key}",
                                //                   style: const TextStyle(
                                //                       color: Colors.black),
                                //                 ),
                                //               ],
                                //             ),
                                //             // const Icon(
                                //             //   CupertinoIcons.chevron_right,
                                //             //   color: Colors.grey,
                                //             // ),
                                //           ],
                                //         ),
                                //         onPressed: () {
                                //           CourseListBinding().dependencies();
                                //           Get.to(() => CourseListPage(
                                //               navigationBarTitle:
                                //                   'Danh mục ${cate.categoryResponse.value?.items?[index].key}',
                                //               category: '${cate.categoryResponse.value?.items?[index].key}',keyword: '',));
                                //         },
                                //       )
                                //       // )
                                //       ;
                                //     }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 0.5,); },)
                                // Container(
                                //   margin: EdgeInsets.only(bottom: statusBarHeight),
                                //   child: Column(children: [
                                //     _listTileAlt(context, 1, "Ngoại ngữ"),
                                //     _listTileAlt(context, 2, "Marketing"),
                                //     _listTileAlt(context, 3, "Tin học văn phòng"),
                                //     _listTileAlt(context, 4, "Thiết kế"),
                                //     _listTileAlt(context, 5, "Kinh doanh - khởi nghiệp"),
                                //     _listTileAlt(context, 6, "Phát triển cá nhân"),
                                //     _listTileAlt(context, 7, "Sales,bán hàng"),
                                //     _listTileAlt(context, 8, "Công nghệ thông tin"),
                                //     _listTileAlt(context, 9, "Sức khỏa - giới tính"),
                                //     _listTileAlt(context, 10, "Phong cách sống"),
                                //     _listTileAlt(context, 11, "Nuôi dạy con"),
                                //     _listTileAlt(context, 12, "Hôn nhân gia đình"),
                                //   ]),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        // Container(height: heightScreen*16/8,),
                        Expanded(child: LoginButton())
                      ]),
                    ),
            )));
  }
}

Widget _listTileAlt(BuildContext context, int index, String text) {
  return CupertinoButton(
    pressedOpacity: 0.65,
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    alignment: Alignment.centerLeft,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: SizedBox(
                  height: 28,
                  width: 28,
                  child: Icon(
                    CupertinoIcons.paperclip,
                    color: Colors.black,
                  )),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        const Icon(
          CupertinoIcons.chevron_right,
          color: Colors.grey,
        ),
      ],
    ),
    onPressed: () {
      CourseListBinding().dependencies();
      Get.to(() => CourseListPage(
            navigationBarTitle: 'Danh mục ${index}',
            category: '',
            keyword: '',
          ));
    },
  );
}
