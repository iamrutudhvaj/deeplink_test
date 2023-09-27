import 'package:deeplink_test/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_page_controller.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationPageView'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: const Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'NotificationPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
