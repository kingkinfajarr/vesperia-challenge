import 'package:entrance_test/src/models/request/login_request_model.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;
  RxBool obscureText = true.obs;
  RxString phoneError = ''.obs;
  RxString passwordError = ''.obs;
  RxBool isLoading = false.obs;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();
  final etCountryCode = TextEditingController(text: '62');

  void doLogin() async {
    if (!validateInput()) {
      return;
    }

    isLoading.value = true;

    if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
      SnackbarWidget.showFailedSnackbar('Email atau password salah');
      isLoading.value = false;
      return;
    }

    try {
      await _userRepository.login(
        LoginRequestModel(
          phoneNumber: etPhone.text,
          password: etPassword.text,
          countryCode: etCountryCode.text,
        ),
      );
    } catch (e) {
      SnackbarWidget.showFailedSnackbar('Failed to login. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInput() {
    bool isValid = true;
    phoneError.value = '';
    passwordError.value = '';

    final phoneRegExp = RegExp(r'^[1-9][0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(etPhone.text)) {
      phoneError.value =
          'Phone number must be 8-16 digits and cannot start with 0';
      isValid = false;
    }

    if (etPassword.text.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      isValid = false;
    }

    return isValid;
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
