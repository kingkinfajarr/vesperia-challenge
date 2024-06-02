import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../dashboard/profile/component/profile_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<ProfileController> {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Web View'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: WebViewWidget(
        controller: controller.controllerWebView,
      ),
    );
  }
}
