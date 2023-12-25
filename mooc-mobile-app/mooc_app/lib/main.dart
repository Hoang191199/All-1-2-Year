import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mooc_app/app/notification/noti.dart';
import 'package:mooc_app/injection.dart';
import 'package:mooc_app/presentation/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // name: "Mooc-app", options: DefaultFirebaseOptions.currentPlatform
      );

  DependencyCreator.init();
  await DependencyCreator.initServices();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler); 

  // String? token = await FirebaseMessaging.instance.getAPNSToken();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const AppWidget()));

  runApp(const AppWidget());
}
