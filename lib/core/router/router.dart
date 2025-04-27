import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:two_fa/core/router/app_routes.dart';
import 'package:two_fa/features/create/create_screen.dart';
import 'package:two_fa/features/sign_in/sign_in_screen.dart';
import 'package:two_fa/features/verify/verify_screen.dart';

// GoRouter configuration
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final router = GoRouter(
  initialLocation: AppRoutes.create_screen,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: false,
  observers: [
    // APlusAnalyticsObserver(FirebaseAnalytics.instance),
  ],
  routes: [
    GoRoute(
      path: AppRoutes.create_screen,
      name: AppRoutes.create_screen,
      pageBuilder: (context, state) => CupertinoPage(child: CreateScreen()),
    ),

    GoRoute(
      path: AppRoutes.sign_in_screen,
      name: AppRoutes.sign_in_screen,
      pageBuilder: (context, state) => CupertinoPage(child: SignInScreen()),
    ),

    GoRoute(
      path: AppRoutes.verify_screen,
      name: AppRoutes.verify_screen,
      pageBuilder: (context, state) => CupertinoPage(child: VerifyScreen(email: state.extra as String)),
    ),
  ],
);
