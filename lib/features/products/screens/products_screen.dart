import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/shared/components/custom_loader.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/products_controller.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            Expanded(
              child: Obx(() => _buildBody()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.screenHorizontal,
        AppSizes.lg,
        AppSizes.screenHorizontal,
        AppSizes.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Products',
            style: TextStyle(
              fontSize: AppSizes.fontSizeH2,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlackColor,
            ),
          ),
          const SizedBox(height: AppSizes.xs),

        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (controller.state.value) {
      case ProductsState.loading:
        return _buildLoadingState();
      case ProductsState.error:
        return _buildErrorState();
      case ProductsState.empty:
        return _buildEmptyState();
      case ProductsState.success:
      case ProductsState.initial:
        return _buildProductList();
    }
  }

  Widget _buildLoadingState() {
    return const Center(child: CustomLoading());
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.wifi_off_rounded, size: 56, color: AppColors.greyColor),
            const SizedBox(height: AppSizes.md),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: AppSizes.fontSizeBodyL,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlackColor,
              ),
            ),
            const SizedBox(height: AppSizes.xs),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.fontSizeBodyS,
                color: AppColors.greyTextColor,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            ElevatedButton.icon(
              onPressed: () => controller.fetchProducts(refresh: true),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.inventory_2_outlined, size: 56, color: AppColors.greyColor),
          const SizedBox(height: AppSizes.md),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: AppSizes.fontSizeBodyL,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return RefreshIndicator(
      onRefresh: () => controller.fetchProducts(refresh: true),
      color: AppColors.primaryColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenHorizontal),
        itemCount: controller.products.length + (controller.isPaginationLoading.value ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == controller.products.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
              child: Center(
                child: CustomLoading(),
              ),
            );
          }

          final ProductModel product = controller.products[index];
          return ProductCard(
            product: product,
            onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: product),
          );
        },
      ),
    );
  }
}
