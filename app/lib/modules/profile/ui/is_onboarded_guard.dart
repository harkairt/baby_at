import 'package:guarded_go_router/guarded_go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsOnboardedGuard extends GoGuard {
  const IsOnboardedGuard(super.read);

  @override
  bool passes() => read(isOnboardedProvider);
}

final isOnboardedProvider = StateProvider<bool>((ref) => false);
