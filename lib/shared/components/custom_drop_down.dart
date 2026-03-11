import 'package:flutter/material.dart';
  import 'package:taghyeer_test/core/extensions/context_extensions.dart';
import '../../core/config/app_colors.dart';
import '../../core/config/app_sizes.dart';
import '../widgets/custom_svg.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  final String iconAssetName;
  final String labelText;
  final T selectedValue;
  final List<DropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool showCheckmarks;
  final bool showDropdownIcon;
  final CustomDropdownStyle? style;

  const CustomDropdownWidget({
    super.key,
    required this.iconAssetName,
    required this.labelText,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.showCheckmarks = true,
    this.showDropdownIcon = true,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final CustomDropdownStyle effectiveStyle = style ?? CustomDropdownStyle.defaultStyle(context);
    final T actualSelectedValue = items.any((DropdownItem<T> item) => item.value == selectedValue)
        ? selectedValue
        : (items.isNotEmpty ? items.first.value : selectedValue);
    return Container(
      padding: effectiveStyle.containerPadding,
      decoration: BoxDecoration(
        borderRadius: effectiveStyle.borderRadius,
        color: effectiveStyle.backgroundColor,
        boxShadow: effectiveStyle.boxShadow,
        border: effectiveStyle.border,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: actualSelectedValue,
          onChanged: onChanged,
          isExpanded: true,
          icon: const SizedBox.shrink(),
          dropdownColor: effectiveStyle.dropdownBackgroundColor,
          borderRadius: effectiveStyle.dropdownBorderRadius,
          elevation: effectiveStyle.dropdownElevation,
          menuMaxHeight: effectiveStyle.maxDropdownHeight,
          selectedItemBuilder: (BuildContext context) =>
              _buildSelectedItem(context, effectiveStyle),
          items: _buildDropdownItems(context, effectiveStyle),
        ),
      ),
    );
  }

  List<Widget> _buildSelectedItem(BuildContext context, CustomDropdownStyle style) {
    final DropdownItem<T> selectedItem = items.firstWhere(
      (DropdownItem<T> item) => item.value == selectedValue,
    );

    return items.map<Widget>((DropdownItem<T> item) {
      return Padding(
        padding: style.itemPadding,
        child: Row(
          children: <Widget>[
            // Leading icon
            CustomSvgImage(assetName: iconAssetName, height: style.iconSize),
            SizedBox(width: style.spacing),

            // Label
            Text(labelText, style: style.labelStyle),

            // Selected value
            Expanded(
              child: Text(
                selectedItem.displayText,
                style: context.txtTheme.labelMedium?.copyWith(color: AppColors.navIconColor),
                textAlign: TextAlign.end,
              ),
            ),

            // Dropdown arrow
            if (showDropdownIcon) ...<Widget>[
              SizedBox(width: style.spacing),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: style.dropdownIconColor,
                size: style.dropdownIconSize,
              ),
            ],
          ],
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<T>> _buildDropdownItems(BuildContext context, CustomDropdownStyle style) {
    return items.map<DropdownMenuItem<T>>((DropdownItem<T> item) {
      final bool isSelected = item.value == selectedValue;

      return DropdownMenuItem<T>(
        value: item.value,
        child: Container(
          padding: style.dropdownItemPadding,
          decoration: BoxDecoration(
            color: isSelected ? style.selectedItemColor : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
          ),
          child: Row(
            children: <Widget>[
              // Item icon (if provided)
              if (item.icon != null) ...<Widget>[
                CustomSvgImage(assetName: item.icon!, height: style.iconSize),
                SizedBox(width: style.spacing),
              ],

              // Item text
              Expanded(
                child: Text(
                  item.displayText,
                  style: isSelected ? style.selectedItemTextStyle : style.itemTextStyle,
                ),
              ),

              // Checkmark for selected item
              if (showCheckmarks && isSelected)
                Icon(Icons.check_rounded, color: style.checkmarkColor, size: style.checkmarkSize),
            ],
          ),
        ),
      );
    }).toList();
  }
}

// Simplified dropdown item class
class DropdownItem<T> {
  final T value;
  final String displayText;
  final String? icon;

  const DropdownItem({required this.value, required this.displayText, this.icon});

  // Factory constructor for common string items
  factory DropdownItem.text(String text) {
    return DropdownItem(value: text as T, displayText: text);
  }
}

// Style configuration class
class CustomDropdownStyle {
  final EdgeInsetsGeometry containerPadding;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  final Color dropdownBackgroundColor;
  final BorderRadius dropdownBorderRadius;
  final int dropdownElevation;
  final double? maxDropdownHeight;

  final EdgeInsetsGeometry itemPadding;
  final EdgeInsetsGeometry dropdownItemPadding;
  final double iconSize;
  final double spacing;

  final TextStyle labelStyle;
  final TextStyle selectedValueStyle;
  final TextStyle itemTextStyle;
  final TextStyle selectedItemTextStyle;

  final Color selectedItemColor;
  final Color checkmarkColor;
  final double checkmarkSize;
  final Color dropdownIconColor;
  final double dropdownIconSize;

  const CustomDropdownStyle({
    required this.containerPadding,
    required this.borderRadius,
    required this.backgroundColor,
    required this.dropdownBackgroundColor,
    required this.dropdownBorderRadius,
    required this.itemPadding,
    required this.dropdownItemPadding,
    required this.labelStyle,
    required this.selectedValueStyle,
    required this.itemTextStyle,
    required this.selectedItemTextStyle,
    required this.selectedItemColor,
    required this.checkmarkColor,
    required this.dropdownIconColor,
    this.boxShadow,
    this.border,
    this.dropdownElevation = 8,
    this.maxDropdownHeight,
    this.iconSize = AppSizes.xxl,
    this.spacing = AppSizes.sm,
    this.checkmarkSize = 20,
    this.dropdownIconSize = 24,
  });

  // Default style factory
  static CustomDropdownStyle defaultStyle(BuildContext context) {
    return CustomDropdownStyle(
      containerPadding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.md),
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
      backgroundColor: AppColors.whiteColor,
      dropdownBackgroundColor: AppColors.whiteColor,
      dropdownBorderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      itemPadding: EdgeInsets.zero,
      dropdownItemPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.sm,
        horizontal: AppSizes.sm,
      ),
      labelStyle: context.txtTheme.bodyMedium?.copyWith() ?? const TextStyle(),
      selectedValueStyle:
          context.txtTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryColor,
          ) ??
          const TextStyle(),
      itemTextStyle:
          context.txtTheme.bodyMedium?.copyWith(color: AppColors.greyTextColor) ?? const TextStyle(),
      selectedItemTextStyle:
          context.txtTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.infoColor,
          ) ??
          const TextStyle(),
      selectedItemColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      checkmarkColor: AppColors.infoColor,
      dropdownIconColor: AppColors.greyColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppColors.blackColor.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Preset styles
  static CustomDropdownStyle elevated(BuildContext context) {
    return defaultStyle(context).copyWith(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppColors.blackColor.withValues(alpha: 0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      dropdownElevation: 12,
    );
  }

  static CustomDropdownStyle outlined(BuildContext context) {
    return defaultStyle(context).copyWith(
      backgroundColor: Colors.transparent,
      border: Border.all(color: AppColors.greyColor, width: 1.5),
      boxShadow: null,
    );
  }

  CustomDropdownStyle copyWith({
    EdgeInsetsGeometry? containerPadding,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    List<BoxShadow>? boxShadow,
    Border? border,
    Color? dropdownBackgroundColor,
    BorderRadius? dropdownBorderRadius,
    int? dropdownElevation,
    double? maxDropdownHeight,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? dropdownItemPadding,
    double? iconSize,
    double? spacing,
    TextStyle? labelStyle,
    TextStyle? selectedValueStyle,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
    Color? selectedItemColor,
    Color? checkmarkColor,
    double? checkmarkSize,
    Color? dropdownIconColor,
    double? dropdownIconSize,
  }) {
    return CustomDropdownStyle(
      containerPadding: containerPadding ?? this.containerPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      boxShadow: boxShadow ?? this.boxShadow,
      border: border ?? this.border,
      dropdownBackgroundColor: dropdownBackgroundColor ?? this.dropdownBackgroundColor,
      dropdownBorderRadius: dropdownBorderRadius ?? this.dropdownBorderRadius,
      dropdownElevation: dropdownElevation ?? this.dropdownElevation,
      maxDropdownHeight: maxDropdownHeight ?? this.maxDropdownHeight,
      itemPadding: itemPadding ?? this.itemPadding,
      dropdownItemPadding: dropdownItemPadding ?? this.dropdownItemPadding,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      labelStyle: labelStyle ?? this.labelStyle,
      selectedValueStyle: selectedValueStyle ?? this.selectedValueStyle,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      selectedItemTextStyle: selectedItemTextStyle ?? this.selectedItemTextStyle,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
      checkmarkSize: checkmarkSize ?? this.checkmarkSize,
      dropdownIconColor: dropdownIconColor ?? this.dropdownIconColor,
      dropdownIconSize: dropdownIconSize ?? this.dropdownIconSize,
    );
  }
}

// Convenience widgets for common use cases
class VolumeUnitDropdown extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String?> onChanged;
  final String iconAssetName;
  final String labelText;
  final CustomDropdownStyle? style;

  const VolumeUnitDropdown({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
    required this.iconAssetName,
    required this.labelText,
    this.style,
  });

  static const List<DropdownItem<String>> volumeUnits = <DropdownItem<String>>[
    DropdownItem(value: 'oz', displayText: ' oz'),
    DropdownItem(value: 'ml', displayText: ' ml'),
    DropdownItem(value: 'cups', displayText: ' cups'),
    DropdownItem(value: 'liters', displayText: ' L'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget<String>(
      iconAssetName: iconAssetName,
      labelText: labelText,
      selectedValue: selectedUnit,
      items: volumeUnits,
      onChanged: onChanged,
      style: style,
    );
  }
}

// Usage examples:
/*
// Simple usage
CustomDropdownWidget<String>(
  iconAssetName: AppIcons.navPumpIcon,
  labelText: 'Volume Unit',
  selectedValue: 'oz',
  items: [
    DropdownItem(value: 'oz', displayText: ' oz'),
    DropdownItem(value: 'ml', displayText: ' ml'),
  ],
  onChanged: (value) => print(value),
)

// With custom style
CustomDropdownWidget<String>(
  iconAssetName: AppIcons.navPumpIcon,
  labelText: 'Volume Unit',
  selectedValue: 'oz',
  items: volumeItems,
  onChanged: (value) => print(value),
  style: CustomDropdownStyle.elevated(context),
)

// Using convenience widget
VolumeUnitDropdown(
  selectedUnit: 'oz',
  onChanged: (value) => print(value),
  iconAssetName: AppIcons.navPumpIcon,
  labelText: 'Volume Unit',
)
*/
