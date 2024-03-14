import 'package:flutter/material.dart';
import 'analyticHelper.dart';

class Pertemuan06Screen extends StatefulWidget {
  const Pertemuan06Screen({super.key});

  @override
  State<Pertemuan06Screen> createState() => _Pertemuan06ScreenState();
}

class _Pertemuan06ScreenState extends State<Pertemuan06Screen> {
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Working with analytics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testSetUserId('Bintang');
                },
                child: const Text("Send Event"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testSetUserProperty();
                },
                child: const Text("Send Property"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testEventLog("send_error");
                },
                child: const Text("Send Error"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
