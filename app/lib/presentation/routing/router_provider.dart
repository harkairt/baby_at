import 'package:app/modules/authentication/ui/is_authentication_guard.dart';
import 'package:app/modules/profile/ui/is_onboarded_guard.dart';
import 'package:app/modules/time_entries/ui/baby_event_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guarded_go_router/guarded_go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';

class R {
  R();
  static const RouteId root = RouteId.path('/');
  static const RouteId login = RouteId.path('login');
  static const RouteId home = RouteId.path('home');
  static const RouteId details = RouteId.path('details');
  static const RouteId onboarding = RouteId.path('onboarding');
  static const RouteId profile = RouteId.path('profile');
}

final routerProvider = Provider<GuardedGoRouter>(
  (ref) => GuardedGoRouter(
    guards: [],
    pageWrapper: (child) => Builder(builder: (context) => Plugger.page(context, child)),
    routerWrapper: (child) => child,
    buildRouter: (routes, rootRedirect) {
      return GoRouter(
        observers: [HeroController()],
        routerNeglect: true,
        redirectLimit: 50,
        redirect: rootRedirect,
        refreshListenable: GoNotifier(
          ref,
          dependencies: [
            authenticationProvider,
            isOnboardedProvider,
          ],
        ),
        routes: routes,
      );
    },
    routes: [
      R.root(redirect: (context, state) => "/${R.home.path}"),
      R.home(
        followUp: [IsAuthenticationGuard],
        pageBuilder: trans(
          (_) => const BabyEventPage(),
        ),
      )
    ],
  ),
);
