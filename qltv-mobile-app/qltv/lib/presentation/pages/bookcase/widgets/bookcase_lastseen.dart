import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_list_view_item.dart';

class BookcaseLastseen extends StatelessWidget {
  BookcaseLastseen({super.key});

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    List<Widget> listLastseen = [];
    if (bookcaseController.bookcasesDataLastseen.isNotEmpty) {
      for (var i = 0; i < bookcaseController.bookcasesDataLastseen.length; i++) {
        listLastseen.add(
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: HexColor('D9E9F2'),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
            child: BookcaseListViewItem(
              type: 'last_seen',
              bookcase: bookcaseController.bookcasesDataLastseen[i],
            ),
          )
        );
      }
    }

    return listLastseen.isNotEmpty 
      ? CarouselSlider.builder(
        itemCount: listLastseen.length,
        itemBuilder: (context, index, ind) => listLastseen[index],
        options: CarouselOptions(
            pageSnapping: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
      )
      : Container();
  }
}