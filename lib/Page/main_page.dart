import 'package:basic/App_bar/app_bar_screen.dart';
import 'package:basic/Bottom_nav/bottom_navigation_screen.dart';
import 'package:basic/Drawer/drawer.dart';
import 'package:basic/Page/member_page/membershipActive_page.dart';
import 'package:basic/Page/Schedule_page/schedule_page.dart';
import 'package:basic/Page/suplemen_page/suplemen_page.dart';
import 'package:basic/Page/TrainerPage/trainer_page.dart';
import 'package:basic/Provider/MyProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? membershipType;

  @override
  void initState() {
    checkMembershipStatus();
    super.initState();
  }

  Future<void> checkMembershipStatus() async {
    final uid = context.read<DataProfileProvider>().uid;
    FirebaseFirestore db = FirebaseFirestore.instance;

    if (uid != null) {
      DocumentSnapshot userDoc = await db.collection('users').doc(uid).get();

      if (userDoc.exists &&
          userDoc.data() != null &&
          (userDoc.data() as Map).containsKey('membershipType')) {
        setState(() {
          membershipType = userDoc['membershipType'];
        });

        if (membershipType != null) {
          final newBodyList = [
            const SchedulePage(),
            const TrainerPage(),
            const MembershipProfile(),
            const SuplemenPage(),
          ];

          context.read<DataProfileProvider>().updateBody(newBodyList);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provTugas2 = context.watch<DataProfileProvider>();

    return Scaffold(
      appBar: const AppBarScreen(),
      body: provTugas2.body[provTugas2.dataCurrentIndex],
      drawer: const Drawerku(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
