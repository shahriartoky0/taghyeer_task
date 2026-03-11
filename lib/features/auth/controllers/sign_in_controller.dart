import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_service/user_session_service.dart';
import '../../../core/config/app_url.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/network/network_response.dart';
import '../../../core/routes/app_routes.dart';
import '../models/user_model.dart';

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString errorMessage = ''.obs;

  final NetworkCaller _networkCaller = NetworkCaller();

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    errorMessage.value = '';
    isLoading.value = true;

    final NetworkResponse response = await _networkCaller.postRequest(
      AppUrl.login,
      body: <String, dynamic>{
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
        'expiresInMins': 30,
      },
      isLogin: true,
    );

    isLoading.value = false;

    if (response.isSuccess && response.jsonResponse != null) {
      final UserModel user = UserModel.fromJson(response.jsonResponse!);
      await UserSessionService.saveUser(user);
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      errorMessage.value =
          response.jsonResponse?['message'] ?? 'Invalid credentials. Please try again.';
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
