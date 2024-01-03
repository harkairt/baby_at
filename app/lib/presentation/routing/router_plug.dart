import 'package:app/presentation/routing/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';

class RouterPlug extends Plug {
  @override
  Widget navigatorPlug(BuildContext context, Widget child) {
    return Consumer(
      builder: (context, ref, _) => ref.watch(routerProvider).deepLinkBuilder(context, child),
    );
  }
}
