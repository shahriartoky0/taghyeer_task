import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../controllers/main_bottom_nav_controller.dart';

class MainBottomNavScreen extends GetView<MainBottomNavController> {
  const MainBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.changeIndexFromPageView,
        itemCount: controller.screens.length,
        itemBuilder: (BuildContext context, int index) => controller.screens[index],
      ),
      bottomNavigationBar: Obx(() => _buildBottomNav()),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.borderColor,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                index: 0,
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Products',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.article_outlined,
                activeIcon: Icons.article_rounded,
                label: 'Posts',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings_rounded,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppSizes.md : AppSizes.sm,
          vertical: AppSizes.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
              size: 22,
            ),
            if (isSelected) ...<Widget>[
              const SizedBox(width: AppSizes.xs),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppSizes.fontSizeBtn,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
