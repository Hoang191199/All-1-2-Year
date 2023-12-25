import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/blog_info.dart';

import '../../../controllers/blog/blog_binding.dart';
import '../../../widgets/blog_item.dart';
import '../../course_list/blog_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlogHomeList extends StatelessWidget {
  const BlogHomeList({
    super.key,
    required this.title,
    // this.collectionHomeItem,
    required this.data,
  });

  final String title;
  // final Collection? collectionHomeItem;
  final List<BlogInfo>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 36.0),
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      BlogBinding().dependencies();
                      Get.to(() => BlogListPage());
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.show_more,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[600])),
                            const SizedBox(width: 2.0),
                            const Icon(
                              CupertinoIcons.forward,
                              size: 16.0,
                              color: Colors.black87,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 230.0,
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 14.0),
                    padding: const EdgeInsets.only(right: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) =>
                        BlogItem(blogItem: data![index])))
          ],
        ));
  }
}
