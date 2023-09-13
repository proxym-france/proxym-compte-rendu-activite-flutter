import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/route/routes.dart';
import 'package:mycra_timesheet_app/features/authentication/page/authentication_page.dart';
import 'package:mycra_timesheet_app/features/createActivity/page/create_activity_page.dart';
import 'package:mycra_timesheet_app/features/onboarding/page/on_boarding_page.dart';
import 'package:mycra_timesheet_app/main.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final goRouterProvider = Provider((ref) {
  final notifier = ref.watch(goRouterNotifierProvider);
  return GoRouter(
    debugLogDiagnostics: true,
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
      return !next.isLoggedIn ? login.path : null;
    },
    routes: [
      GoRoute(
        path: home.path,
        name: home.name,
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigator,
            path: createActivity.path,
            name: createActivity.name,
            builder: (context, state) => CreateActivityPage(firstDayOfWeek: DateTime.parse(state.pathParameters['firstDayOfWeek']!)),
          ),
        ],
        pageBuilder: (context, state) => NoTransitionPage(child: MyHomePage(title: root.displayName)),
      ),
      GoRoute(
        path: root.path,
        name: root.name,
        pageBuilder: (context, state) => NoTransitionPage(child: MyHomePage(title: root.displayName)),
      ),
      GoRoute(
        path: onBoarding.path,
        name: onBoarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(child: OnBoardingPage()),
      ),
      GoRoute(
        path: login.path,
        name: login.name,
        pageBuilder: (context, state) => const NoTransitionPage(child: AuthenticationPage()),
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
