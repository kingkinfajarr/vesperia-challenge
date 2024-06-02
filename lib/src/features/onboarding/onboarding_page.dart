import 'package:carousel_slider/carousel_slider.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/features/onboarding/component/onboarding_controller.dart';
import 'package:entrance_test/src/widgets/button_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingPage extends GetView<OnboardingController> {
  OnboardingPage({super.key});

  final List<String> titles = [
    'Grow Your\nFinancial Today',
    'Build From\nZero to Freedom',
    'Start Together',
  ];

  final List<String> subtitles = [
    'Our system is helping you to\nachieve a better goal',
    'We provide tips for you so that\nyou can adapt easier',
    'We will guide you to where\nyou wanted it too',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  'assets/images/img_onboarding1.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/images/img_onboarding2.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/images/img_onboarding3.png',
                  height: 331,
                ),
              ],
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
              ),
              carouselController: controller.carouselController,
            ),
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Obx(
                    () => Text(
                      titles[controller.currentIndex.value],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Obx(
                    () => Text(
                      subtitles[controller.currentIndex.value],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIndicator(controller.currentIndex.value == 0),
                        _buildIndicator(controller.currentIndex.value == 1),
                        _buildIndicator(controller.currentIndex.value == 2),
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: controller.currentIndex.value == 2 ? 38 : 50,
                    ),
                  ),
                  Obx(
                    () => controller.currentIndex.value == 2
                        ? Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ButtonIcon(
                                  textLabel: 'Finish',
                                  onClick: () {
                                    Get.offAllNamed(RouteName.login);
                                  },
                                  textColor: white,
                                  buttonColor: primary,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              ButtonIcon(
                                onClick: () {
                                  Get.offAllNamed(RouteName.login);
                                },
                                textLabel: 'Skip',
                              ),
                              const Spacer(),
                              ButtonIcon(
                                onClick: () {
                                  controller.carouselController.nextPage();
                                },
                                textLabel: 'Next',
                                buttonColor: primary,
                                textColor: white,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? primary : gray100,
      ),
    );
  }
}
