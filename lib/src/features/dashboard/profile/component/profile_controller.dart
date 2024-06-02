import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late final WebViewController controllerWebView;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();

    controllerWebView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=lpnKWK-KEYs'));
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick(String url, String name) async {
    try {
      await _userRepository.downloadFile(url, name);
      SnackbarWidget.showSuccessSnackbar("File downloaded successfully");
    } catch (e) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(e));
    }
  }

  onOpenWebPageClick(String url) async {
    // controllerWebView.loadRequest(Uri.parse(url));
    Get.toNamed(RouteName.webView, arguments: url);
  }

  void doLogout() async {
    _isLoading.value = true;
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
    _isLoading.value = false;
  }
}
