import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/components/custom_loader.dart';
import '../controllers/posts_controller.dart';
import '../models/post_model.dart';
import '../widgets/post_card.dart';

class PostsScreen extends GetView<PostsController> {
  const PostsScreen({super.key});

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
      child: Text(
        'Posts',
        style: TextStyle(
          fontSize: AppSizes.fontSizeH2,
          fontWeight: FontWeight.w700,
          color: AppColors.textBlackColor,
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (controller.state.value) {
      case PostsState.loading:
        return const Center(child: CircularProgressIndicator());
      case PostsState.error:
        return _buildErrorState();
      case PostsState.empty:
        return _buildEmptyState();
      case PostsState.success:
      case PostsState.initial:
        return _buildPostList();
    }
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
              style: TextStyle(fontSize: AppSizes.fontSizeBodyS, color: AppColors.greyTextColor),
            ),
            const SizedBox(height: AppSizes.lg),
            ElevatedButton.icon(
              onPressed: () => controller.fetchPosts(refresh: true),
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
          Icon(Icons.article_outlined, size: 56, color: AppColors.greyColor),
          const SizedBox(height: AppSizes.md),
          Text(
            'No posts found',
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

  Widget _buildPostList() {
    return RefreshIndicator(
      onRefresh: () => controller.fetchPosts(refresh: true),
      color: AppColors.primaryColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenHorizontal),
        itemCount: controller.posts.length + (controller.isPaginationLoading.value ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == controller.posts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
              child: Center(
                child:  CustomLoading(),
              ),
            );
          }

          final PostModel post = controller.posts[index];
          return PostCard(
            post: post,
            onTap: () => Get.toNamed(AppRoutes.postDetail, arguments: post),
          );
        },
      ),
    );
  }
}
