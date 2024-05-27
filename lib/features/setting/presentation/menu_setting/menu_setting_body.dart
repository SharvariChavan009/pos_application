import 'package:flutter/material.dart';
import 'package:pos_application/features/setting/presentation/menu_setting/menu_body/discount_body.dart';
import 'package:pos_application/features/setting/presentation/menu_setting/menu_body/menu_list_body.dart';

class MenuSettingBody extends StatefulWidget {
  final TabController optionsController;
  const MenuSettingBody({required this.optionsController, super.key});

  @override
  State<MenuSettingBody> createState() => _MenuSettingBodyState();
}

class _MenuSettingBodyState extends State<MenuSettingBody> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.optionsController,
      children: const [
        MenuListSetting(),
        DiscountList(),
        Center(child: Text('Content for Tab 4')),
      ],
    );
  }
}
