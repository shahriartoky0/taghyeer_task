import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textBlackColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Post Details',
          style: TextStyle(
            color: AppColors.textBlackColor,
            fontSize: AppSizes.fontSizeBodyL,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (post.tags.isNotEmpty)
              Wrap(
                spacing: AppSizes.xs,
                children: post.tags
                    .map(
                      (String tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        margin: const EdgeInsets.only(bottom: AppSizes.xs),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeBodyS,
                            color: AppColors.navIconColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: AppSizes.md),
            Text(
              post.title,
              style: TextStyle(
                fontSize: AppSizes.fontSizeH3,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlackColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Divider(color: AppColors.dividerColor, height: 1),
            const SizedBox(height: AppSizes.md),
            Text(
              post.body,
              style: TextStyle(
                fontSize: AppSizes.fontSizeBodyM,
                color: AppColors.greyTextColor,
                height: 1.7,
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStat(Icons.thumb_up_outlined, '${post.likes}', 'Likes'),
                  _buildVerticalDivider(),
                  _buildStat(Icons.thumb_down_outlined, '${post.dislikes}', 'Dislikes'),
                  _buildVerticalDivider(),
                  _buildStat(Icons.remove_red_eye_outlined, '${post.views}', 'Views'),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: <Widget>[
        Icon(icon, color: AppColors.primaryColor, size: 20),
        const SizedBox(height: AppSizes.xs),
        Text(
          value,
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyM,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlackColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyS,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 40, color: AppColors.dividerColor);
  }
}
