import 'package:app_links/app_links.dart';
import 'package:deeplink_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      onInit: () {
        final appLinks = AppLinks();
        appLinks.allUriLinkStream.listen(
          (uri) async {
            final link = uri.toString();
            if (link.contains('profile')) {
              Get.toNamed(Routes.PROFILE_PAGE);
            }
            if (link.contains('notification')) {
              Get.toNamed(Routes.NOTIFICATION_PAGE);
            }
          },
        );
      },
    ),
  );
}
