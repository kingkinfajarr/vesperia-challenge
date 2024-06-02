import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  CarouselController carouselController = CarouselController();
}
