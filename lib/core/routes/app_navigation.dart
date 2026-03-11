import 'package:get/get.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/main_nav/bindings/main_nav_binding.dart';
import '../../features/main_nav/screens/main_bottom_nav_screen.dart';
import '../../features/products/models/product_model.dart';
import '../../features/products/screens/product_detail_screen.dart';
import '../../features/posts/models/post_model.dart';
import '../../features/posts/screens/post_detail_screen.dart';
import 'app_routes.dart';

export 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainBottomNavScreen(),
      binding: MainNavBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailScreen(
        product: Get.arguments as ProductModel,
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => PostDetailScreen(
        post: Get.arguments as PostModel,
      ),
      transition: Transition.rightToLeft,
    ),
  ];
}
