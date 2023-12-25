import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class SupportParentDetailsPage extends StatelessWidget {
  SupportParentDetailsPage({super.key, this.index1, this.index2, this.id});

  final int? index1;
  final int? index2;
  final String? id;
  final store = Get.find<LocalStorageService>();
  final mediaController = Get.find<MediaController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
      init: mediaController,
      initState: (_) async {
        await mediaController.getDetail(id ?? "");
      },
      builder: (_) => GestureDetector(
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
              'Trợ lý cha mẹ',
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
          child: mediaController.isdetailLoading.value ? 
          const Center(
            child: CircularLoadingIndicator()
          ) : 
          mediaController.detail.value != null ? 
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widthScreen / 2,
                    width: widthScreen,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: mediaController.listdouble[index1 ?? 0][index2 ?? 0]?.thumbnail != null && mediaController.listdouble[index1 ?? 0][index2 ?? 0]?.thumbnail != "" ? 
                      Image(
                        height: widthScreen / 2,
                        width: widthScreen,
                        image: CachedNetworkImageProvider(
                          "${mediaController.listdouble[index1 ?? 0][index2 ?? 0]?.thumbnail}",
                        ),
                        fit: BoxFit.cover
                      ) : 
                      Image(
                        height: widthScreen / 2,
                        width: widthScreen,
                        image: const AssetImage("assets/images/avatar-mac-dinh.png"),
                        fit: BoxFit.cover
                      ),
                    )
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: AppColors.starYellow,
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                    child: Text(
                      DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(mediaController.listdouble[index1 ?? 0][index2 ?? 0]?.post_date ?? "")),
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  Html(
                    doNotRenderTheseTags: const {"img"},
                    data:"${(mediaController.detail.value?.content?.rendered)?.replaceAll(r'\', r"")}"
                  ),
                ],
              ),
            )
          ) : 
          Container()
        )
      )
    );
  }
}
