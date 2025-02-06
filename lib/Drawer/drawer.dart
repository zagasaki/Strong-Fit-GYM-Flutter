import 'package:basic/Page/Login&Register_page/login_page.dart';
import 'package:basic/Provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:basic/Page/profile_page.dart';
import 'package:provider/provider.dart';

class Drawerku extends StatefulWidget {
  const Drawerku({super.key, Key});

  @override
  State<Drawerku> createState() => _DrawerkuState();
}

class _DrawerkuState extends State<Drawerku> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
        color: const Color(0xffb28242c),
        child: Column(
          children: [
            const Text(
              "StrongFit Gym",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            ListTile(
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () => themeProvider.toggleTheme(),
              child: Text("Change Theme"),
            ),
            const Expanded(child: SizedBox()),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onTap: () async {
                await _handleSignOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
