import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';

class ItemStudent extends StatelessWidget {
  ItemStudent({
    super.key,
    required this.index,
    this.data
  });

  final int index;
  final ItemChild? data;
  final currencyFormat = getCurrencyFormatVN();
  final serviceController = Get.find<ServiceController>(); 

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: serviceController,
      builder: (_) { 
      var serviceTemp = List<ItemChild>.from(serviceController.listItemChild);

        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: 
                      data?.child_picture == null ?
                      const Image(
                        image: AssetImage(
                          'assets/images/avatar-mac-dinh.png',
                        ),
                        fit: BoxFit.cover
                      )
                    : CachedNetworkImage(
                        imageUrl:  data?.child_picture ?? '',
                        progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                        errorWidget: (context, url, error) => const AvatarError(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '${index + 1}. ${data?.child_name}',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: List.generate(
                  data?.service?.length ?? 0,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey
                        )
                      )
                    ),
                    width: widthScreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data?.service?[index].service_name ?? '',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColors.green,
                              value: data?.service?[index].check,
                              onChanged: (bool? value) {
                                data?.service?[index].check = value!;
                                serviceController.listItemChild.value = serviceTemp;
                              },
                            ),
                            SizedBox(
                              width: 60.0,
                              child: Text(currencyFormat.format(int.parse(data?.service?[index].fee ?? '0')),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
