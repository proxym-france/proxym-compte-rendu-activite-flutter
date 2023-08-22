import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/route/routes.dart';
import 'package:mycra_timesheet_app/features/authentication/page/authentication_page.dart';
import 'package:mycra_timesheet_app/features/onboarding/page/OnboardingPage.dart';
import 'package:mycra_timesheet_app/main.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final goRouterProvider = Provider((ref) {
  final notifier = ref.watch(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigator,
    refreshListenable: notifier,
    errorPageBuilder: (context, state) => NoTransitionPage(
        child: Scaffold(
      body: Center(
        child: Text(state.error?.message ?? 'error loading page'),
      ),
    )),
    redirect: (context, state) async {
      final next = notifier.state;
      if (!next.isOnline) return error.path;
      return next.isLoggedIn ? root.path : login.path;
    },
    routes: [
      GoRoute(
        path: root.path,
        name: root.name,
        pageBuilder: (context, state) => NoTransitionPage(child: MyHomePage(title: root.displayName)),
      ),
      GoRoute(
        path: onBoarding.path,
        name: onBoarding.name,
        pageBuilder: (context, state) => NoTransitionPage(child: OnBoardingPage()),
      ),
      GoRoute(
        path: login.path,
        name: login.name,
        pageBuilder: (context, state) => NoTransitionPage(child: AuthenticationPage()),
      ),
      GoRoute(
        path: error.path,
        name: error.name,
        pageBuilder: (context, state) => NoTransitionPage(
            child: Scaffold(
          body: Center(
            child: Text(state.error?.message ?? 'error loading page'),
          ),
        )),
      )
    ],
  );
});
