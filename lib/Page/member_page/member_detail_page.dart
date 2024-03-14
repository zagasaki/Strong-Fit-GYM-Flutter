import 'package:basic/Page/TrainerPage/trainer_page.dart';
import 'package:basic/Page/member_page/memberModel.dart';
import 'package:basic/Page/member_page/membershipActive_page.dart';
import 'package:basic/Page/Schedule_page/schedule_page.dart';
import 'package:basic/Page/suplemen_page/suplemen_page.dart';
import 'package:basic/Provider/MyProvider.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberDetailPage extends StatefulWidget {
  final EventModel member;
  const MemberDetailPage({Key? key, required this.member}) : super(key: key);
  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Purchase'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to buy this member package?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('buy'),
              onPressed: () {
                Navigator.of(context).pop();
                buyMembership();
              },
            ),
          ],
        );
      },
    );
  }

  Future buyMembership() async {
    final uid = context.read<DataProfileProvider>().uid;

    final DateTime currentDate = DateTime.now();
    final DateTime expiryDate = currentDate.add(const Duration(days: 30));

    try {
      await db.collection('users').doc(uid).update({
        'membershipType': widget.member.tipemember,
        'membershipExpiryDate': expiryDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Member package purchase was successful'),
        ),
      );

      final newBodyList = [
        const SchedulePage(),
        const TrainerPage(),
        const MembershipProfile(),
        const SuplemenPage(),
      ];

      context.read<DataProfileProvider>().updateBody(newBodyList);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error purchasing membership. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbase,
      appBar: AppBar(
        backgroundColor: colorbase,
        title:
            const Text('Member Details', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Member Type: ${widget.member.tipemember}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Member Price: ${widget.member.hargamember}/Month',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.member.deskripsi,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Benefits:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            for (var item in widget.member.benefit)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await showConfirmationDialog();
                Navigator.pop(context);
              },
              child: const Text("Buy"),
            )
          ],
        ),
      ),
    );
  }
}
