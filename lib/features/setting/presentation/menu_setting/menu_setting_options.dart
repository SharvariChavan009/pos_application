import 'package:flutter/material.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';

class MenuSettingOptions extends StatefulWidget {
  const MenuSettingOptions({required this.optionsController, super.key});

  final TabController optionsController;

  @override
  State<MenuSettingOptions> createState() => _MenuSettingOptionsState();
}

class _MenuSettingOptionsState extends State<MenuSettingOptions>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.transparent, width: .3),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        padding: EdgeInsets.zero,
        automaticIndicatorColorAdjustment: true,
        tabAlignment: TabAlignment.start,
        controller: widget.optionsController,
        unselectedLabelColor: AppColors.whiteColor,
        indicatorColor: AppColors.secondaryColor,
        labelStyle: const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: CustomLabels.mediumFontWeight),
        unselectedLabelStyle: const TextStyle(
            fontFamily: CustomLabels.primaryFont,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
            letterSpacing: .5,
            fontWeight: CustomLabels.mediumFontWeight),
        tabs: const [
          Tab(text: 'Menu List'),
          Tab(text: 'Discount'),
          Tab(text: 'Add List'),
        ],
      ),
    );
  }
}
