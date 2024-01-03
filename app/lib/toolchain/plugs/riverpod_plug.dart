import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';

class RiverpodPlug extends Plug {
  @override
  PlugWiring appPlug() => PlugWiring((child) => ProviderScope(child: child));
}
