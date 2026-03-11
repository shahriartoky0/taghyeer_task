import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_sizes.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ProductModel p = widget.product;
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
          'Product Details',
          style: TextStyle(
            color: AppColors.textBlackColor,
            fontSize: AppSizes.fontSizeBodyL,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageGallery(p),
            Padding(
              padding: const EdgeInsets.all(AppSizes.screenHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCategoryChip(p),
                  const SizedBox(height: AppSizes.sm),
                  _buildTitle(p),
                  const SizedBox(height: AppSizes.sm),
                  _buildRatingAndStock(p),
                  const SizedBox(height: AppSizes.md),
                  _buildPrice(p),
                  const SizedBox(height: AppSizes.md),
                  _buildDivider(),
                  const SizedBox(height: AppSizes.md),
                  _buildDescription(p),
                  const SizedBox(height: AppSizes.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(ProductModel p) {
    final List<String> allImages = <String>[p.thumbnail, ...p.images];
    return Column(
      children: <Widget>[
        Container(
          height: 280,
          color: AppColors.surfaceColor,
          child: Image.network(
            allImages[_selectedImageIndex],
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.image_outlined, color: AppColors.greyColor, size: 64),
          ),
        ),
        if (allImages.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.screenHorizontal,
              vertical: AppSizes.sm,
            ),
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: allImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSizes.xs),
                itemBuilder: (BuildContext context, int i) {
                  final bool isSelected = _selectedImageIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedImageIndex = i),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                        child: Image.network(allImages[i], fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const SizedBox.shrink()),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryChip(ProductModel p) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: Text(
        p.category.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildTitle(ProductModel p) {
    return Text(
      p.title,
      style: TextStyle(
        fontSize: AppSizes.fontSizeH3,
        fontWeight: FontWeight.w700,
        color: AppColors.textBlackColor,
      ),
    );
  }

  Widget _buildRatingAndStock(ProductModel p) {
    return Row(
      children: <Widget>[
        Icon(Icons.star_rounded, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          p.rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlackColor,
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Icon(Icons.inventory_2_outlined, color: AppColors.greyColor, size: 16),
        const SizedBox(width: 4),
        Text(
          '${p.stock} in stock',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(ProductModel p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '\$${p.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: AppSizes.fontSizeH2,
            fontWeight: FontWeight.w800,
            color: AppColors.textBlackColor,
          ),
        ),
        if (p.discountPercentage > 0) ...<Widget>[
          const SizedBox(width: AppSizes.sm),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.successColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${p.discountPercentage.toStringAsFixed(0)}% off',
                style: TextStyle(
                  fontSize: AppSizes.fontSizeBodyS,
                  color: AppColors.successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.dividerColor, height: 1);
  }

  Widget _buildDescription(ProductModel p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBodyM,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlackColor,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          p.description,
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            color: AppColors.greyTextColor,
            height: 1.6,
          ),
        ),
        if (p.brand.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSizes.md),
          _buildInfoRow('Brand', p.brand),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: <Widget>[
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlackColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: AppSizes.fontSizeBtn,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }
}
