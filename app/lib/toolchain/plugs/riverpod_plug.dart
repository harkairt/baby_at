import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stored_notifier/default_storage_provider.dart';
import 'package:stored_notifier/storages/shared_preferences_storage.dart';

class RiverpodPlug extends Plug {
  @override
  PlugWiring appPlug() {
    return PlugWiring((child) async {
      final sharedPrefs = await SharedPreferences.getInstance();
      final sharedPrefsStorage = SharedPreferencesStorage(instance: sharedPrefs);

      return ProviderScope(
        overrides: [
          defaultJsonAsyncStorageProvider.overrideWithValue(sharedPrefsStorage),
        ],
        child: child,
      );
    });
  }
}
