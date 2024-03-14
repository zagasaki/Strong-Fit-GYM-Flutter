import 'package:basic/Page/cart_page.dart';
import 'package:basic/style/style.dart';
import 'package:flutter/material.dart';

class SuplemenPage extends StatefulWidget {
  const SuplemenPage({Key? key}) : super(key: key);

  @override
  State<SuplemenPage> createState() => _SuplemenPageState();
}

class _SuplemenPageState extends State<SuplemenPage> {
  List<Map<String, dynamic>> suplemenList = [
    {
      "name": "Evolene BCAA Branch Chain 350 Gram",
      "category": "BCCA",
      "price": "Rp 440.000",
      "assetPath": "assets/suplemen2.jpeg",
    },
    {
      "name": "M1 Muscle First Gold Pro Creatine 350 Gram",
      "category": "Creatine",
      "price": "Rp 550.000",
      "assetPath": "assets/suplemen1.jpeg",
    },
    {
      "name": "Universal Fat Burner 55 Tablet",
      "category": "Fat Burner",
      "price": "Rp 440.000",
      "assetPath": "assets/suplemen3.jpeg",
    },
    {
      "name": "Evolene Evomass Gainer 2 lbs 912 Gram",
      "category": "Gainer",
      "price": "Rp 193.000",
      "assetPath": "assets/suplemen4.jpeg",
    },
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredSuplemenList = [];

  @override
  void initState() {
    super.initState();
    filteredSuplemenList = suplemenList;
  }

  void filterSuplemen(String query) {
    setState(() {
      filteredSuplemenList = suplemenList
          .where((suplemen) =>
              suplemen['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  "Suplemen Shop",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            // Widget Search
            Container(
              margin: EdgeInsets.fromLTRB(
                screenWidth * 0.1,
                screenHeight * 0.02,
                screenWidth * 0.1,
                screenHeight * 0.02,
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: searchController,
                onChanged: filterSuplemen,
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
            Expanded(
              child: Scrollbar(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children:
                      _buildSupplementItems(filteredSuplemenList, screenWidth),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.001,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: const Text("Lihat Keranjang"),
            ),
            SizedBox(
              height: screenHeight * 0.001,
            ), // Added some extra spacing at the bottom
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSupplementItems(
      List<Map<String, dynamic>> suplemenList, double screenWidth) {
    return suplemenList.map((suplemen) {
      return _buildSupplementItem(
        suplemen['name'],
        suplemen['category'],
        suplemen['price'],
        suplemen['assetPath'],
        screenWidth,
      );
    }).toList();
  }

  Widget _buildSupplementItem(
    String name,
    String category,
    String price,
    String assetPath,
    double screenWidth,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(3, 10, 3, 10),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: screenWidth * 0.2,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.4,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Add to Cart"))
            ],
          )
        ],
      ),
    );
  }
}
