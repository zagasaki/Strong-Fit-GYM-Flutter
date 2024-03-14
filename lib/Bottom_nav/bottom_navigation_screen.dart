import 'package:basic/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final provTugas2 = context.watch<DataProfileProvider>();
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      onTap: (idx) {
        provTugas2.setCurrentIndex = idx;
      },
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_sharp, color: Colors.white),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility_new_outlined,
              color: Colors.white,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.wallet_membership, color: Colors.white),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded, color: Colors.white),
            label: "")
      ],
    );
  }
}
