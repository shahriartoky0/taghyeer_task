import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.md),
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSizes.fontSizeBodyM,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlackColor,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              post.bodyPreview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSizes.fontSizeBtn,
                color: AppColors.greyTextColor,
                height: 1.5,
              ),
            ),
            if (post.tags.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSizes.sm),
              Wrap(
                spacing: AppSizes.xs,
                runSpacing: AppSizes.xs,
                children: post.tags
                    .take(3)
                    .map(
                      (String tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.navIconColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: AppSizes.sm),
            Row(
              children: <Widget>[
                Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.greyColor),
                const SizedBox(width: 4),
                Text(
                  '${post.likes}',
                  style: TextStyle(fontSize: 12, color: AppColors.greyTextColor),
                ),
                const SizedBox(width: AppSizes.md),
                Icon(Icons.remove_red_eye_outlined, size: 14, color: AppColors.greyColor),
                const SizedBox(width: 4),
                Text(
                  '${post.views}',
                  style: TextStyle(fontSize: 12, color: AppColors.greyTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
