import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/widgets/circle_contain_asset.dart';

class NewsFeedAvatar extends StatelessWidget {
  const NewsFeedAvatar({
    super.key,
    this.imageNetwork,
    this.radius,
    this.backgroundColor,
    this.linkAsset,
    this.sizeAsset,
  });

  final String? imageNetwork;
  final double? radius;
  final String? backgroundColor;
  final String? linkAsset;
  final double? sizeAsset;

  @override
  Widget build(BuildContext context) {
    return imageNetwork == null || (imageNetwork?.isEmpty ?? false)
      ? noAvatar(context)
      : CachedNetworkImage(
        imageUrl: imageNetwork ?? '',
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: radius ?? context.responsive(19.0),
          backgroundImage: imageProvider,
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => noAvatar(context),
        errorWidget: (context, url, error) => noAvatar(context),
      );
  }

  Widget noAvatar(BuildContext context) {
    return CircleContainAsset(
      radius: radius ?? context.responsive(19.0),
      backgroundColor: backgroundColor ?? 'D8D8D8',
      linkAsset: linkAsset ?? 'assets/images/person.png',
      sizeAsset: sizeAsset ?? context.responsive(14.0),
    );
  }
}