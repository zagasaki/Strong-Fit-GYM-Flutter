import 'package:basic/Page/member_page/memberModel.dart';
import 'package:basic/Page/member_page/member_detail_page.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin {
  List<EventModel> details = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      var data = await db.collection('member_package').get();

      if (mounted) {
        setState(() {
          details =
              data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      color: colorbase,
      child: Column(
        children: [
          for (var member in details)
            Card(
              elevation: 4,
              color: appbarcolor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.card_membership,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      member.tipemember,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Premium access to unlock other benefits.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${member.hargamember}/Month",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MemberDetailPage(member: member)));
                      },
                      child: const Text('details'),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
