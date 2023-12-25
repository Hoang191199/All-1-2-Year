import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class PhotoGrid extends StatelessWidget {
  PhotoGrid({
    super.key,
    required this.imageUrls,
    this.maxImages = 3,
    required this.legthImage,
    this.id,
    this.type
  });

  final int maxImages;
  final int legthImage;
  final List<String> imageUrls;
  final String? id;
  final String? type;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    List<String> newImageUrls = [];
    if (imageUrls.isNotEmpty) {
      newImageUrls = List.from(imageUrls);
      newImageUrls.removeAt(0);
    }
    return Column(
      children: [
        if(legthImage == 1)
        GestureDetector(
          onTap: () {
            if(type == 'detail'){
              NewsFeedBinding().dependencies();
              ShowPageBinding().dependencies();
              ShowGroupBinding().dependencies();
              SavedPostsBinding().dependencies();
              HomePageBinding('').dependencies();
              Get.to(() => NewsFeedPostDetailPage(
                  from: PostNewsFrom.newsFeedPage,
                  postId: id ?? '0',
                )
              );
            }
          },
          child:  ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(
              imageUrls[0],
              fit: BoxFit.cover,
              width: widthScreen,
              height: 200,
            ),
          )
        ),
        if(legthImage == 2)
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1.0,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            children: List.generate(2, (index) {
              return GestureDetector(
                onTap: () {
                  if(type == 'detail'){
                    NewsFeedBinding().dependencies();
                    ShowPageBinding().dependencies();
                    ShowGroupBinding().dependencies();
                    SavedPostsBinding().dependencies();
                    HomePageBinding('').dependencies();
                    Get.to(() => NewsFeedPostDetailPage(
                        from: PostNewsFrom.newsFeedPage,
                        postId: id ?? '0',
                      )
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    width: widthScreen,
                  ),
                )
              );
            })
          )
        ),
        if(legthImage == 3)
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if(type == 'detail'){
                  NewsFeedBinding().dependencies();
                  ShowPageBinding().dependencies();
                  ShowGroupBinding().dependencies();
                  SavedPostsBinding().dependencies();
                  HomePageBinding('').dependencies();
                  Get.to(() => NewsFeedPostDetailPage(
                      from: PostNewsFrom.newsFeedPage,
                      postId: id ?? '0',
                    )
                  );
                }
              },
              child:  ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  imageUrls[0],
                  fit: BoxFit.cover,
                  width: widthScreen,
                  height: 200,
                ),
              )
            ),
            const SizedBox(height: 10.0),
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 1.2,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              children: List.generate(2, (index) {
                return GestureDetector(
                  onTap: () {
                    if(type == 'detail'){
                    NewsFeedBinding().dependencies();
                    ShowPageBinding().dependencies();
                    ShowGroupBinding().dependencies();
                    SavedPostsBinding().dependencies();
                    HomePageBinding('').dependencies();
                    Get.to(() => NewsFeedPostDetailPage(
                        from: PostNewsFrom.newsFeedPage,
                        postId: id ?? '0',
                      )
                    );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(
                      newImageUrls[index],
                      fit: BoxFit.cover,
                      width: widthScreen,
                    ),
                  )
                );
              })
            )
          ],
        ),
        if(legthImage == 4)
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if(type == 'detail'){
                  NewsFeedBinding().dependencies();
                  ShowPageBinding().dependencies();
                  ShowGroupBinding().dependencies();
                  SavedPostsBinding().dependencies();
                  HomePageBinding('').dependencies();
                  Get.to(() => NewsFeedPostDetailPage(
                      from: PostNewsFrom.newsFeedPage,
                      postId: id ?? '0',
                    )
                  );
                }
              },
              child:  ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  imageUrls[0],
                  fit: BoxFit.cover,
                  width: widthScreen,
                  height: 200,
                ),
              )
            ),
            const SizedBox(height: 10.0),
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 1.2,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              crossAxisCount: 3,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    if(type == 'detail'){
                      NewsFeedBinding().dependencies();
                      ShowPageBinding().dependencies();
                      ShowGroupBinding().dependencies();
                      SavedPostsBinding().dependencies();
                      HomePageBinding('').dependencies();
                      Get.to(() => NewsFeedPostDetailPage(
                          from: PostNewsFrom.newsFeedPage,
                          postId: id ?? '0',
                        )
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(
                      newImageUrls[index],
                      fit: BoxFit.cover,
                      width: widthScreen,
                    ),
                  )
                );
              })
            )
          ],
        ),
        if(legthImage >= 5)
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if (type == 'detail') {
                  NewsFeedBinding().dependencies();
                  ShowPageBinding().dependencies();
                  ShowGroupBinding().dependencies();
                  SavedPostsBinding().dependencies();
                  HomePageBinding('').dependencies();
                  Get.to(() => NewsFeedPostDetailPage(
                      from: PostNewsFrom.newsFeedPage,
                      postId: id ?? '0',
                    )
                  );
                }
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  imageUrls[0],
                  fit: BoxFit.cover,
                  width: widthScreen,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                crossAxisCount: 3,
                children: buildImages(imageUrls),
              ),
            )
          ],
        )
      ],
    );
  }

  List<Widget> buildImages(List<String> displayedUrls) {
    int numImages = displayedUrls.length;
    List<String> newListImageUrls = [];
    newListImageUrls = List.from(displayedUrls);
    newListImageUrls.removeAt(0);

    return List<Widget>.generate(min(numImages, maxImages), (index) {
      if (index == (maxImages) - 1) {
        int remaining = numImages - (maxImages) - 1;

        if (remaining == 0) {
          return GestureDetector(
            onTap: () {
              if(type == 'detail'){
                NewsFeedBinding().dependencies();
                ShowPageBinding().dependencies();
                ShowGroupBinding().dependencies();
                SavedPostsBinding().dependencies();
                HomePageBinding('').dependencies();
                Get.to(() => NewsFeedPostDetailPage(
                    from: PostNewsFrom.newsFeedPage,
                    postId: id ?? '0',
                  )
                );
              }
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                newListImageUrls[index],
                fit: BoxFit.cover,
              ),
            )
          );
        } else {
          return GestureDetector(
            onTap: () {
              if (type == 'detail') {
                NewsFeedBinding().dependencies();
                ShowPageBinding().dependencies();
                ShowGroupBinding().dependencies();
                SavedPostsBinding().dependencies();
                HomePageBinding('').dependencies();
                Get.to(() => NewsFeedPostDetailPage(
                    from: PostNewsFrom.newsFeedPage,
                    postId: id ?? '0',
                  )
                );
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    newListImageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+$remaining',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey2,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
            onTap: () {
              if (type == 'detail') {
                NewsFeedBinding().dependencies();
                ShowPageBinding().dependencies();
                ShowGroupBinding().dependencies();
                SavedPostsBinding().dependencies();
                HomePageBinding('').dependencies();
                Get.to(() => NewsFeedPostDetailPage(
                    from: PostNewsFrom.newsFeedPage,
                    postId: id ?? '0',
                  )
                );
              }
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                newListImageUrls[index],
                fit: BoxFit.cover,
              ),
            )
          );
        }
      }
    );
  }
}