import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../products/screens/products_screen.dart';
import '../../posts/screens/posts_screen.dart';
import '../../settings/screens/settings_screen.dart';

class MainBottomNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  late PageController pageController;

  final List<Widget> screens = const <Widget>[
    ProductsScreen(),
    PostsScreen(),
    SettingsScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeIndexFromPageView(int index) {
    selectedIndex.value = index;
  }
}
