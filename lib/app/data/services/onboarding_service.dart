import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class OnboardingService {
  static const _key = 'onboarding';

  static Future<bool> hasUserOnboarded() async {
    return (await RxSharedPreferences.getInstance().getBool(_key)) ?? false;
  }

  static Future<void> setUserOnboarded() async {
    await RxSharedPreferences.getInstance().setBool(_key, true);
  }
}
