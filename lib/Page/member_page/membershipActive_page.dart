import 'package:basic/Provider/MyProvider.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembershipProfile extends StatefulWidget {
  const MembershipProfile({Key? key}) : super(key: key);

  @override
  _MembershipProfileState createState() => _MembershipProfileState();
}

class _MembershipProfileState extends State<MembershipProfile>
    with AutomaticKeepAliveClientMixin {
  String? membershipType;
  DateTime? membershipExpiryDate;
  List<String>? benefits;

  @override
  void initState() {
    super.initState();
    loadMembershipData();
  }

  Future<void> loadMemberPackage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot memberPackageDoc =
        await db.collection('member_package').doc(membershipType).get();

    setState(() {
      benefits = List<String>.from(memberPackageDoc['benefit']);
    });
  }

  Future<void> loadMembershipData() async {
    final uid = context.read<DataProfileProvider>().uid;
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot userDoc = await db.collection('users').doc(uid).get();

    setState(() {
      membershipType = userDoc['membershipType'];
      membershipExpiryDate = userDoc['membershipExpiryDate']?.toDate();
    });

    if (membershipType != null) {
      await loadMemberPackage();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final name = context.read<DataProfileProvider>().username;
    return Scaffold(
      backgroundColor: colorbase,
      appBar: AppBar(
        backgroundColor: colorbase,
        title: Text('$name`s Membership Profile',
            style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Membership Type:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              membershipType ?? "There isn't any yet",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Membership benefits:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            if (benefits != null)
              for (var benefit in benefits!)
                Text(
                  '- $benefit',
                  style: const TextStyle(color: Colors.grey),
                ),
            const SizedBox(height: 16),
            const Text(
              'Expired date:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              membershipExpiryDate != null
                  ? "${membershipExpiryDate!.day}/${membershipExpiryDate!.month}/${membershipExpiryDate!.year}"
                  : "There isn't any yet",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
