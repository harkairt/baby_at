import 'package:guarded_go_router/guarded_go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsAuthenticationGuard extends GoGuard {
  const IsAuthenticationGuard(super.read);

  @override
  bool passes() => read(authenticationProvider);
}

final authenticationProvider = StateProvider<bool>((ref) => false);
