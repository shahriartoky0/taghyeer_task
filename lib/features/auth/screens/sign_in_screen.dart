import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenHorizontal),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 72),
                _buildHeader(),
                const SizedBox(height: 48),
                _buildUsernameField(),
                const SizedBox(height: AppSizes.md),
                _buildPasswordField(),
                const SizedBox(height: AppSizes.sm),
                _buildErrorMessage(),
                const SizedBox(height: AppSizes.lg),
                _buildSignInButton(),
                const SizedBox(height: AppSizes.lg),
                _buildHint(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.person_rounded, color: AppColors.primaryColor, size: 26),
        ),
        const SizedBox(height: AppSizes.lg),
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: AppSizes.fontSizeH1,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlackColor,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyM,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlackColor,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        TextFormField(
          controller: controller.usernameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          style: TextStyle(color: AppColors.textBlackColor, fontSize: AppSizes.fontSizeBodyM),
          decoration: InputDecoration(
            hintText: 'Enter your username',
            filled: true,
            fillColor: AppColors.surfaceColor,
            prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.greyColor),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.md,
            ),
          ),
          validator: (String? value) {
            if (value == null || value.trim().isEmpty) return 'Username is required';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlackColor,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        Obx(
          () => TextFormField(
            controller: controller.passwordController,
            obscureText: !controller.isPasswordVisible.value,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.signIn(),
            style: TextStyle(color: AppColors.textBlackColor, fontSize: AppSizes.fontSizeBodyM),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              filled: true,
              fillColor: AppColors.surfaceColor,
              prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.greyColor),
              suffixIcon: GestureDetector(
                onTap: controller.togglePasswordVisibility,
                child: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) return 'Password is required';
              if (value.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Obx(() {
      if (controller.errorMessage.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(top: AppSizes.xs),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.redColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(color: AppColors.redColor.withOpacity(0.3)),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.error_outline_rounded, color: AppColors.redColor, size: 16),
              const SizedBox(width: AppSizes.xs),
              Expanded(
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: AppColors.redColor,
                    fontSize: AppSizes.fontSizeBodyS,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSignInButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.signIn,
          child: controller.isLoading.value
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.whiteColor,
                  ),
                )
              : Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: AppSizes.fontSizeBodyM,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHint() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Demo credentials: ',
          style: TextStyle(color: AppColors.greyTextColor, fontSize: AppSizes.fontSizeBodyS),
          children: <InlineSpan>[
            TextSpan(
              text: 'emilys / emilyspass',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
