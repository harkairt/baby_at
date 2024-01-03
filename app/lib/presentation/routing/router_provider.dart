import 'package:app/modules/authentication/ui/is_authentication_guard.dart';
import 'package:app/modules/profile/ui/is_onboarded_guard.dart';
import 'package:app/presentation/responsive/nested_navigation.dart';
import 'package:app/presentation/routing/placeholder_page.dart';
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
    guards: [
      IsAuthenticationGuard(ref.read),
      IsOnboardedGuard(ref.read),
    ],
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
      R.login(
        shieldOf: [IsAuthenticationGuard],
        pageBuilder: trans(
          (_) => PlaceholderPage(
            title: 'Login',
            body: OutlinedButton(
              onPressed: () => ref.read(authenticationProvider.notifier).state = true,
              child: const Text('Let me in!'),
            ),
          ),
        ),
      ),
      GuardShell<IsAuthenticationGuard>(
        [
          StatefulShellRoute.indexedStack(
            pageBuilder: (context, state, navigationShell) => buildDefaultTransitionPage<void>(
              context: context,
              state: state,
              child: NestedNavigation(navigationShell: navigationShell),
            ),
            branches: [
              StatefulShellBranch(
                routes: [
                  R.home(
                    followUp: [IsAuthenticationGuard],
                    pageBuilder: trans(
                      (_) => PlaceholderPage(
                        title: 'Dashboard',
                        body: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.dashboard),
                            const SizedBox(width: 16),
                            Builder(
                              builder: (context) {
                                return IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    GoRouter.of(context).goNamed(R.details.name);
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    routes: [
                      R.details(
                        pageBuilder: trans(
                          (_) => const PlaceholderPage(
                            title: 'Details',
                            body: Icon(Icons.book),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  R.onboarding(
                    shieldOf: [IsOnboardedGuard],
                    pageBuilder: trans(
                      (_) => PlaceholderPage(
                        title: 'Who are you?',
                        body: ElevatedButton(
                          onPressed: () => ref.read(isOnboardedProvider.notifier).state = true,
                          child: const Text('I am John Doe!'),
                        ),
                      ),
                    ),
                  ),
                  GuardShell<IsOnboardedGuard>([
                    R.profile(
                      followUp: [IsOnboardedGuard],
                      pageBuilder: trans(
                        (_) => const PlaceholderPage(
                          title: 'Profile',
                          body: Text('Hey John Doe! 👋'),
                        ),
                      ),
                    ),
                  ]),
                ],
              )
            ],
          ),
        ],
      )
    ],
  ),
);
