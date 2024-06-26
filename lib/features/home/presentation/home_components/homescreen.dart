import 'package:flutter/material.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/features/home/presentation/home_components/drawer/drawer.dart';
import 'package:pos_application/features/home/presentation/home_components/home_screen_components.dart';
import 'package:pos_application/features/home/presentation/home_components/home_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 12, vsync: this);
  }


  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Row(
          children: [
            const SidebarPage(),
            buildContentColumn(context, tabController),
            buildBlueColumn(),
          ],
        ),
    );
  }
}
