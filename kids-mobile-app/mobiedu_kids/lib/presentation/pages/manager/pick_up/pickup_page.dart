import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class PickUpPage extends StatelessWidget {
  PickUpPage({super.key, this.child_id});

  final String? child_id;

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {
        await childController.info(store.getGroupname, child_id ?? "");
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
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
            middle: Text(
              'Người đón học sinh',
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
          child: childController.ispickerLoading.value ? 
          const Center(
            child: CircularLoadingIndicator()
          ) : 
          childController.picker_info.isEmpty ? 
          const NoData() : 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childController.picker_info.length,
              itemBuilder: (context, index) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: childController.picker_info[index]?.picker_source_file != "" && childController.picker_info[index]?.picker_source_file != null ? 
                      Image(
                        height: (widthScreen - 56.0 - 50),
                        width: (widthScreen - 56.0 - 50),
                        image: CachedNetworkImageProvider(
                          "${childController.picker_info[index]?.picker_source_file}"
                        ),
                        fit: BoxFit.cover
                      ) : 
                      Image(
                        height: (widthScreen - 56.0 - 50),
                        width: (widthScreen - 56.0 - 50),
                        image: const AssetImage("assets/images/avatar-mac-dinh.png"),
                        fit: BoxFit.cover
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    infoPickup(widthScreen, childController.picker_info[index]?.picker_relation, childController.picker_info[index]?.picker_name),
                    const SizedBox(height: 12.0),
                    infoPickup(widthScreen, 'Điện thoại', childController.picker_info[index]?.picker_phone),
                    const SizedBox(height: 12.0),
                    infoPickup(widthScreen, 'Địa chỉ', childController.picker_info[index]?.picker_address)
                  ]
                )
              ),
            )
          )
        )
      )
    );
  }
  Widget infoPickup(double widthScreen, String? title, String? info){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: (widthScreen - 56) / 2 - 50,
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                "$title :",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ]
          )
        ),
        const SizedBox( width: 20.0),
        SizedBox(
          width: (widthScreen - 56) / 2,
          child: Text(
            "$info",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
          )
        )
      ]
    );
  }
}
