import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return CupertinoPageScaffold(
        backgroundColor: const Color(0xffFCF5F3),
        child: Container(
          padding: EdgeInsets.only(
              bottom: bottomPadding + 20.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: Text('${'welcome'.tr}\nQuản lý thư viện',
                    style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8e2912)),
                    textAlign: TextAlign.center),
              )),
              SizedBox(
                width: widthScreen,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        elevation: 0.0,
                        backgroundColor: const Color(0xffE58362),
                        textStyle: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: Text(
                        'log-in'.tr,
                        style: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                width: widthScreen,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            side: BorderSide(color: Color(0xffEBE6E8))),
                        elevation: 0.0,
                        backgroundColor: const Color(0xffFFFDFD),
                        textStyle: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: Text(
                        'register'.tr,
                        style: const TextStyle(
                            fontSize: 17.0, color: Color(0xff8E2912)),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
