import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventLog(value) async {
    await analytics
        .logEvent(name: '${value}_click', parameters: {'Value': value});
    print("Send Event");
  }

  Future<void> testSetUserId(value) async {
    await analytics.setUserId(id: '$value');
    print('setUserId succeded');
  }

  Future<void> testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    print('setUserProperty succeded');
  }
}
