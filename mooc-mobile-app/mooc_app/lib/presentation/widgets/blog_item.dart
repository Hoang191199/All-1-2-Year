import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/blog_info.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/blog/blog_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_binding.dart';
import 'package:mooc_app/presentation/pages/course_detail/course_detail_page.dart';
import 'package:mooc_app/presentation/widgets/blog_detail_page.dart';

class BlogItem extends StatelessWidget {
  BlogItem({
    Key? key,
    this.widthItem,
    this.blogItem,
  }) : super(key: key);

  final double? widthItem;
  final BlogInfo? blogItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
           BlogBinding().dependencies();
           Get.to(() => BlogDetailPage(slug: blogItem!.slug));
        },
        child: Container(
          width: widthItem ?? 160.0,
          padding: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // width: widthItem ?? 160.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: blogItem?.thumbnailFileUrl != null
                            ? DecorationImage(
                          // image: NetworkImage(courseItem?.image_url ?? ''),
                            image: CachedNetworkImageProvider(blogItem?.thumbnailFileUrl ?? ''),
                            fit: BoxFit.cover
                        )
                            : const DecorationImage(
                            image: AssetImage('assets/images/course_image.png'),
                            fit: BoxFit.cover
                        ),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                      ),
                    ),
                //     getDiscountPercent().isNotEmpty
                //         ? Positioned(
                //         top: 0.0,
                //         right: 0.0,
                //         child: Container(
                //           padding: const EdgeInsets.all(6.0),
                //           decoration: const BoxDecoration(
                //               color: Colors.red,
                //               borderRadius: BorderRadius.only(
                //                   topRight: Radius.circular(5.0),
                //                   bottomLeft: Radius.circular(5.0)
                //               )
                //           ),
                //           child: Text(
                //               getDiscountPercent(),
                //               style: const TextStyle(fontSize: 12.0, color: Colors.white, letterSpacing: 0.4)
                //           ),
                //         )
                //     )
                //         : const SizedBox()
                  ],
                ),
                Container(
                  width: widthItem ?? 160.0,
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text(
                      blogItem?.name ?? "",
                      style: const TextStyle(fontSize: 15.0, color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
                // Expanded(
                //     child: Align(
                //         alignment: FractionalOffset.bottomLeft,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Container(
                //               width: widthItem ?? 160.0,
                //               margin: const EdgeInsets.only(top: 12.0),
                //               padding: const EdgeInsets.only(left: 10.0),
                //               child: Row(mainAxisSize: MainAxisSize.min, children: [
                //                 Text(
                //                     '',
                //                     style: const TextStyle(fontSize: 10, color: Colors.black45)
                //                 )
                //               ]),
                //             ),
                //             Container(
                //               margin: const EdgeInsets.only(top: 12.0),
                //               padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                //               child: Row(
                //                 children: [
                //                   Row(
                //                     children: [
                //                       Container(
                //                         margin: const EdgeInsets.only(right: 1.0),
                //                         child: Text(
                //                             "",
                //                             style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.black)
                //                         ),
                //                       ),
                //                       const Text('₫', style: TextStyle(fontSize: 12.0, color: Colors.black)),
                //                     ],
                //                   ),
                //                   const SizedBox(width: 6.0),
                //                   Row(
                //                     children: [
                //                       Container(
                //                         margin: const EdgeInsets.only(right: 1.0),
                //                         child: Text(
                //                             "",
                //                             style: const TextStyle(fontSize: 11.0, color: Colors.black45, decoration: TextDecoration.lineThrough)
                //                         ),
                //                       ),
                //                       const Text('₫', style: TextStyle(fontSize: 9.0, color: Colors.black45, decoration: TextDecoration.lineThrough)),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         )
                //     )
                // ),
              ]
          ),
        )
    );
  }

  // String getDiscountPercent() {
  //   if (courseItem?.price != null && courseItem!.price > 0) {
  //     double percent = ((courseItem!.price - (courseItem?.sale_price ?? 0)) / courseItem!.price) * 100;
  //     return '-${percent.ceil()}%';
  //   }
  //   return '';
  // }
}
