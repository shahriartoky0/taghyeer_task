import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: AppSizes.lg),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: AppSizes.fontSizeH2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlackColor,
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              _buildProfileSection(),
              const SizedBox(height: AppSizes.lg),
              _buildSectionTitle('Preferences'),
              const SizedBox(height: AppSizes.sm),
              _buildThemeToggle(),
              const SizedBox(height: AppSizes.lg),
              _buildSectionTitle('Account'),
              const SizedBox(height: AppSizes.sm),
              _buildLogoutButton(),
              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Obx(() {
      final user = controller.user.value;
      return Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxl),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: <Widget>[
            _buildAvatar(user?.image),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user?.fullName ?? '—',
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeBodyL,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user?.username ?? '—'}',
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeBtn,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user?.email ?? '—',
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeBodyS,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAvatar(String? imageUrl) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withOpacity(0.12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3), width: 2),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildAvatarFallback(),
              )
            : _buildAvatarFallback(),
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Icon(Icons.person_rounded, color: AppColors.primaryColor, size: 32);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AppSizes.fontSizeBodyS,
        fontWeight: FontWeight.w700,
        color: AppColors.greyTextColor,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: ListTile(
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            ),
            child: Icon(
              controller.isDarkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
          title: Text(
            'Dark Mode',
            style: TextStyle(
              fontSize: AppSizes.fontSizeBodyM,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlackColor,
            ),
          ),
          subtitle: Text(
            controller.isDarkMode ? 'Dark theme is on' : 'Light theme is on',
            style: TextStyle(
              fontSize: AppSizes.fontSizeBodyS,
              color: AppColors.greyTextColor,
            ),
          ),
          trailing: Switch(
            value: controller.isDarkMode,
            onChanged: controller.toggleTheme,
            activeColor: AppColors.primaryColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.xs,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        border: Border.all(color: AppColors.redColor.withOpacity(0.2)),
      ),
      child: ListTile(
        onTap: controller.logout,
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.redColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          child: Icon(Icons.logout_rounded, color: AppColors.redColor, size: 20),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyM,
            fontWeight: FontWeight.w600,
            color: AppColors.redColor,
          ),
        ),
        subtitle: Text(
          'Sign out of your account',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyS,
            color: AppColors.redColor.withOpacity(0.6),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.xs,
        ),
      ),
    );
  }
}
