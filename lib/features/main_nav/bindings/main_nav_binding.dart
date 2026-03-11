import 'package:get/get.dart';
import '../../products/bindings/products_binding.dart';
import '../../posts/bindings/posts_binding.dart';
import '../../settings/bindings/settings_binding.dart';
import '../controllers/main_bottom_nav_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBottomNavController>(() => MainBottomNavController());
    ProductsBinding().dependencies();
    PostsBinding().dependencies();
    SettingsBinding().dependencies();
  }
}
