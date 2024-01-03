import 'package:app/presentation/routing/router_provider.dart';
import 'package:app/presentation/routing/router_plug.dart';
import 'package:app/toolchain/error_tracking/error_tracking_plug.dart';
import 'package:app/toolchain/error_tracking/sentry_plug.dart';
import 'package:app/toolchain/plugs/riverpod_plug.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  Plugger.runApp(
    const App(),
    plugs: <Plug>[
      RiverpodPlug(),
      ErrorTrackingPlug(
        onError: (error, chain) {
          Sentry.captureException(error, stackTrace: chain.sanitized);
          debugPrint('🔥 $error \n${chain.sanitized.toString()}');
        },
      ),
      SentryPlug(dsn: 'https://697d64dbdae4493c8a0254a3b469be53@o4505358017101824.ingest.sentry.io/4505358018215936'),
      RouterPlug(),
    ],
  );
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider).goRouter,
      builder: (context, child) => Plugger.navigator(context, child ?? const SizedBox()),
    );
  }
}
