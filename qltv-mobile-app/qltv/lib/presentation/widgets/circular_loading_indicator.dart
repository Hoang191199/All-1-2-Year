import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qltv/app/config/app_colors.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS 
      ? const CupertinoActivityIndicator() 
      : SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
          strokeWidth: 2.0
        ),
      );
  }
}