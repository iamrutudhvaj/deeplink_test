import 'package:app_links/app_links.dart';
import 'package:deeplink_test/app/modules/notification_page/controllers/notification_page_controller.dart';
import 'package:deeplink_test/app/modules/notification_page/views/notification_page_view.dart';
import 'package:deeplink_test/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:deeplink_test/app/modules/profile_page/views/profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    ),
  );
}

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    Path(
      r'^' + Routes.HOME,
      (context, match) {
        Get.lazyPut<HomeController>(
          () => HomeController(),
        );
        return const HomeView();
      },
    ),
    Path(
      r'^' + Routes.PROFILE_PAGE,
      (context, match) {
        Get.lazyPut<ProfilePageController>(
          () => ProfilePageController(),
        );
        return const ProfilePageView();
      },
    ),
    Path(
      r'^' + Routes.NOTIFICATION_PAGE,
      (context, match) {
        Get.lazyPut<NotificationPageController>(
          () => NotificationPageController(),
        );
        return const NotificationPageView();
      },
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (settings.name != null &&
          regExpPattern.hasMatch(settings.name ?? '')) {
        final firstMatch = regExpPattern.firstMatch(settings.name!);
        final match =
            (firstMatch!.groupCount == 1) ? firstMatch.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match!),
          settings: settings,
        );
      }
    }
    return null;
  }
}
