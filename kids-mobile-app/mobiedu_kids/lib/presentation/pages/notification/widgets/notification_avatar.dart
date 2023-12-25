import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/presentation/widgets/circle_contain_asset.dart';

class NotificationAvatar extends StatelessWidget {
  const NotificationAvatar({
    super.key,
    this.userPicture,
    this.action,
  });

  final String? userPicture;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        userPicture == null || (userPicture?.isEmpty ?? false)
          ? noAvatar()
          : CachedNetworkImage(
            imageUrl: userPicture ?? '',
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 32.0,
              backgroundImage: imageProvider,
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) => noAvatar(),
            errorWidget: (context, url, error) => noAvatar(),
          ),
        if (action != null && (action?.isNotEmpty ?? false))
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: CircleAvatar(
              radius: 12.0,
              backgroundColor: HexColor(action == ActionNotification.like ? '1A74E4' : 'F1B821'),
              child: Center(
                child: Image.asset(
                  action == ActionNotification.like ? 'assets/images/notification-like.png' : 'assets/images/notification-bell.png',
                  width: action == ActionNotification.like ? 12.0 : 14.0,
                  height: action == ActionNotification.like ? 12.0 : 14.0,
                  fit: BoxFit.cover,
                ),
              ),
            )
          )
      ],
    );
  }

  Widget noAvatar() {
    return const CircleContainAsset(
      radius: 32.0,
      backgroundColor: 'D8D8D8',
      linkAsset: 'assets/images/person.png',
      sizeAsset: 24.0,
    );
  }
}