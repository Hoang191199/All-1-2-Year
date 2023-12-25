import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchNoData extends StatelessWidget {
  const SearchNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80.0),
          child: Image.asset(
            'assets/images/search_nodata.png',
            width: 200.0,
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text('search-no-data'.tr,
              style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
        )
      ],
    );
  }
}
