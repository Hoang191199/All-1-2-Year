import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';

class ViewImagePage extends StatefulWidget {
  const ViewImagePage({
    super.key,
    required this.imageNetworkUrlArr,
    this.selectIndexPage
  });

  final List<String> imageNetworkUrlArr;
  final int? selectIndexPage;

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  
  late PageController pageController;
  int activePage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectIndexPage ?? 0);
    activePage = widget.selectIndexPage ?? 0;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // final PageController pageController = PageController(initialPage: widget.selectIndexPage ?? 0);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
        child: Column(
          children: [
            Text(
              '${activePage + 1}/${widget.imageNetworkUrlArr.length}',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                children: imageView(context),
              )
            )
          ],
        ),
      ),
    );
  }

  List<Widget> imageView(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    List<Widget> listViewImage = [];
    for (var element in widget.imageNetworkUrlArr) {
      listViewImage.add(Center(
        child: ItemImageRect(
          imageUrl: element, 
          width: widthScreen,
          borderRadius: 0.0,
        ),
      ));
    }
    return listViewImage;
  }
}