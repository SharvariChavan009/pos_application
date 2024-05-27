import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_application/features/auth/presentation/login.dart';
import 'package:pos_application/features/home/presentation/home_components/homescreen.dart';
import 'package:pos_application/features/setting/presentation/setting_screen.dart';
import 'package:pos_application/features/splash/presentation/splash_screen.dart';

GoRouter customRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(), // Pass the global key here
    ),
  ],
);
