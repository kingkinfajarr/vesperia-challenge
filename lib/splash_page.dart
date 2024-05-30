import 'dart:io';

import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'src/constants/color.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String versionInfo = '';

  @override
  void initState() {
    super.initState();
    _getVersionInfo();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(RouteName.login);
    });
  }

  Future<void> _getVersionInfo() async {
    if (Platform.isAndroid || Platform.isIOS) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        versionInfo = packageInfo.version;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primary,
                  primary.withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Image.asset(
                logoImage,
                width: 170,
                height: 170,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                versionInfo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
