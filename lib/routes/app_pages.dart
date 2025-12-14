import 'package:kids_learning/modules/onboarding/screen/onboarding_view.dart';
import 'package:kids_learning/modules/home/screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kids_learning/routes/app_routes.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  navigatorKey:
      GlobalNavigation.instance.navigatorKey, // Use the global key here
  routes: [
    GoRoute(
      name: Names.onboarding,
      path: Routes.onboarding,
      builder: (context, state) => const CharacterSelectorScreen(),
    ),

    GoRoute(
      name: Names.init,
      path: Routes.init,
      builder: (context, state) => const CharacterSelectorScreen(),
    ),
    GoRoute(
      name: Names.home,
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

class GlobalNavigation {
  static final GlobalNavigation instance = GlobalNavigation._internal();
  GlobalNavigation._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
