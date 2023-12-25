import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';

class DialofAudioTTS extends StatelessWidget {
  DialofAudioTTS({
    super.key,
    required this.epubController,
  });

  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.only(bottom: bottomPadding + 20.0 + 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => publicationDigitalController.handleFlutterTTS.value != HandleAudio.playing
              ? IconButton(
                onPressed: () {
                  handlePressPlay();
                }, 
                icon: Icon(CupertinoIcons.play_fill, color: HexColor('7B858B'))
              )
              : IconButton(
                onPressed: () {
                  handlePressPause();
                }, 
                icon: Icon(CupertinoIcons.pause_fill, color: HexColor('7B858B'))
              )
          ),
          const SizedBox(width: 20.0),
          IconButton(
            onPressed: () {
              handlePressStop();
            }, 
            icon: Icon(CupertinoIcons.stop_fill, color: HexColor('7B858B'))
          ),
        ],
      ),
    );
  }
  
  void handlePressPlay() {
    publicationDigitalController.playEpubAudio(epubController);
  }

  void handlePressPause() {
    publicationDigitalController.pauseEpubAudio();
  }
  
  void handlePressStop() {
    publicationDigitalController.stopEpubAudio();
  }
}