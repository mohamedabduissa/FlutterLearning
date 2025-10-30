import 'package:firebase_analytics/firebase_analytics.dart';

// --- 2. Service ---
class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logSignUp(String signUpMethod) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logItemView(String itemId) async {
    await _analytics.logEvent(
      name: 'view_item',
      parameters: {'item_id': itemId},
    );
  }
}
