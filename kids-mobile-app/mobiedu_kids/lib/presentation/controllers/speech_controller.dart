import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class STTController extends GetxController {
  static STTController get to => Get.find<STTController>();
  late SpeechToText speechToText;
  late TextEditingController temp;
  var isListening = false.obs;
  @override
  void onInit() {
    temp = TextEditingController(text: "");
    speechToText = SpeechToText();
    super.onInit();
  }

  toggle(TextEditingController tc) async {
    if (!isListening.value) {
      bool available = await speechToText.initialize(
        onStatus: (status) => print(status),
        onError: (err) => print(err),
      );
      if (available) {
        isListening.value = true;
        temp.text = "";
        update();
        speechToText.listen(onResult: (value) {
          tc.text = value.recognizedWords;
          temp.text = value.recognizedWords;
          update();
          // if(value.hasConfidenceRating && value.confidence > 0){
          //   confidence = value.confidence;
          // }
        });
      }
    } else {
      isListening.value = false;
      temp.text = "";
      update();
      speechToText.stop();
    }
  }
}
