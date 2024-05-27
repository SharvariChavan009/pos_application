import 'package:auto_size_text/auto_size_text.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/transition.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/auth/presentation/login.dart';
import 'package:pos_application/features/home/presentation/home_components/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogoVisible = true;

  Future<void> checkLoginStatus() async {
    var box = await Hive.openBox('authBox');

    // header["Authorization"]="Bearer ${box.get("authToken")}";
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
    Future.delayed(const Duration(milliseconds: 50), () {
      try {
        String? authToken = box.get("authToken");
        print("authToken =$authToken");
        Navigator.of(context).push(
          MyCustomRouteTransition(
            route: (box.get("authToken") == null)
                ? const LoginPage()
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
  }

  Future<bool> isImageSets() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => false,
    );
  }

  Widget getAnimationContainer({bool isImageSet = true}) {
    return LayoutBuilder(
      builder: (context, size) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              height:
                  isImageSet ? 550 : MediaQuery.of(context).size.height / 1.5,
              width: isImageSet ? 550 : 250,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 1),
              top: isImageSet ? size.maxHeight : 20,
              child: Image.asset(
                AppImage.logo1,
                height: 300,
                width: 500,
                fit: BoxFit.fitWidth,
              ),
            ),
            const FadeOutParticle(
              curve: Easing.emphasizedAccelerate,
              disappear: true,
              duration: Duration(milliseconds: 4000),
              child: AutoSizeText(
                'Empowering Your Culinary Journey',
                minFontSize: 25,
                maxFontSize: 30,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  decorationColor: AppColors.whiteColor,
                  fontSize: 30,
                  fontWeight: CustomLabels.largeFontWeight,
                  fontFamily: CustomLabels.secondaryFont,
                ),
                maxLines: 1,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            extendBody: true,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImage.splash,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'Logo',
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 2),
                          opacity: isLogoVisible ? 1.0 : 1.0,
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: getAnimationContainer(
                                  isImageSet: isLogoVisible),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoadingState()) {
    on<SplashLoading>((event, emit) {
      emit(SplashLoadingState());
    });
    on<SplashLoaded>((event, emit) {
      emit(SplashLoadedState());
    });
    on<SplashDone>((event, emit) => emit(SplashDoneState()));
  }

  void setLoaded() {
    Future.delayed(const Duration(seconds: 3), () {
      add(SplashLoaded());
    });
  }

  void setDone() {
    Future.delayed(const Duration(seconds: 2), () {
      add(SplashDone());
    });
  }
}

abstract class SplashEvent {}

class SplashLoading extends SplashEvent {}

class SplashLoaded extends SplashEvent {}

class SplashDone extends SplashEvent {}

abstract class SplashState {}

class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashDoneState extends SplashState {}
