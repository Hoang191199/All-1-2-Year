// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobiedu_kids/presentation/controllers/app_life_controller.dart';

// class AppLifecycleOverlay extends StatelessWidget {
//   AppLifecycleOverlay({
//     super.key,
//     required this.child,
//   });

//   final applife = Get.put(AppLifeController());
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     if (applife.shouldBlur.value) {
//       return Stack(
//         children: [
//           child,
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.grey.shade200.withOpacity(0.5),
//             ),
//           ),
//         ],
//       );
//     }

//     return child;
//   }
// }
