import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/core/images/image.dart';

import '../../../core/common/colors.dart';
import '../../../core/common/label.dart';
import '../../../core/common/transition.dart';
import '../../auth/presentation/login_screen.dart';
import '../../home/presentation/home_components/homescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isLogoVisible = true;

  Future<void> checkLoginStatus() async {
    var box = await Hive.openBox('authBox');

    Future.delayed(
      const Duration(milliseconds: 300),
          () {
        setState(
              () {
            isLogoVisible = false;
          },
        );
      },
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      try {
        String? authToken = box.get("authToken");
        print("authToken =$authToken");
        Navigator.of(context).push(
          MyCustomRouteTransition(
            route: (box.get("authToken") == null)
                ? const LoginScreen()
                : HomeScreen(),
          ),
        );
      } catch (e) {
        debugPrint('Error navigating to LoginScreen: $e');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<bool> isImageSets() {
    return Future.delayed(
      const Duration(seconds: 2),
          () => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          // color: Colors.white
          image: DecorationImage(
            image: AssetImage(
              "assets/image/splash.webp",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child:  Center(
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              FadeTransition(
              opacity: _animation,
                child:Image.asset(
                  AppImage.appLogo2,
                  height: 100,
                  width: 200,
                  fit: BoxFit.fill,
                ),),
                SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                optionName!.empoweringYourCulinaryJourney,
                minFontSize: 25,
                maxFontSize: 30,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: AppColors.whiteColor,
                  fontSize: 30,
                  fontWeight: CustomLabels.largeFontWeight,
                  fontFamily: CustomLabels.secondaryFont,
                ),
                maxLines: 1,
              ),



            ],

        )
        )
      ),
    );
  }
}
