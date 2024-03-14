import 'package:basic/Page/suplemen_page/Seller.dart';
import 'package:basic/Page/suplemen_page/cart_page.dart';
import 'package:basic/Page/suplemen_page/SuplemenModel.dart';
import 'package:basic/Page/suplemen_page/suplemen_detail_page.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SuplemenPage extends StatefulWidget {
  const SuplemenPage({Key? key}) : super(key: key);

  @override
  State<SuplemenPage> createState() => _SuplemenPageState();
}

class _SuplemenPageState extends State<SuplemenPage>
    with AutomaticKeepAliveClientMixin {
  List<EventModel> details = [];
  TextEditingController searchController = TextEditingController();
  List<EventModel> filteredSuplemenList = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('suplemen_shop').get();
    setState(() {
      details =
          data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
      filteredSuplemenList = details;
    });
  }

  void filterSuplemen(String query) {
    setState(() {
      filteredSuplemenList = details
          .where((suplemen) =>
              suplemen.namasuplemen
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              suplemen.jenissuplemen
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: colorbase,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, screenHeight * 0.01, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Suplemen Shop",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    onChanged: (query) {
                      filterSuplemen(query);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: screenWidth *
                        0.02), // Add spacing between the TextField and buttons
                ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Seller(),
                      ),
                    );
                  },
                  child: const Text("Sell Items"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: const Text("Cart"),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                ),
                itemCount: filteredSuplemenList.length,
                itemBuilder: (context, index) {
                  EventModel suplemen = filteredSuplemenList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SuplemenDetailPage(suplemen: suplemen)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            suplemen.gambarsuplemen,
                            width: double.infinity,
                            height: screenHeight * 0.145,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  suplemen.namasuplemen,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Type: ${suplemen.jenissuplemen}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Price: ${suplemen.hargasuplemen}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.001),
            const SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
            SizedBox(height: screenHeight * 0.001),
          ],
        ),
      ),
    );
  }
}
