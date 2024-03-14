import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:basic/Provider/MyProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Set<int> selectedItems = <int>{};
  List<Map<String, dynamic>> cartItems = [];
  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  @override
  void initState() {
    super.initState();
    _loadinterstisialAd();
  }

  Future<void> _showInterstitialAd() async {
    if (_isInterstitialReady) {
      _interstitialAd.show();
    } else {
      print("ca-app-pub-3940256099942544/1033173712");
    }
  }

  void _loadinterstisialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _isInterstitialReady = true;
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          _isInterstitialReady = false;
          _interstitialAd.dispose();
        },
      ),
    );
  }

  Future<void> _showCheckoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Checkout Confirmation"),
          content: const Text("Are you sure you want to checkout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _handleCheckout();
                Navigator.of(context).pop();
              },
              child: const Text("Checkout"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleCheckout() async {
    await _showInterstitialAd();
    // Perform checkout logic
    // Show toast message
    Fluttertoast.showToast(
      msg: "Checkout confirmed. Your purchase is being processed.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // Show AdMob banner after checkout
    // (You can adjust the ad unit ID and ad size accordingly)
    // AdMob initialization is done in _AdMobBannerState's initState
  }

  void _handleDeleteSelectedItems() async {
    final uid = context.read<DataProfileProvider>().uid;
    setState(() {
      List<Map<String, dynamic>> updatedCartItems = List.from(cartItems);
      List<int> sortedIndexes = selectedItems.toList()
        ..sort((a, b) => b.compareTo(a));

      for (int index in sortedIndexes) {
        if (index >= 0 && index < updatedCartItems.length) {
          String documentId = updatedCartItems[index]['documentId'];
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('cart')
              .doc(documentId)
              .delete();

          updatedCartItems.removeAt(index);
        }
      }

      selectedItems.clear();
      cartItems = updatedCartItems;
    });
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content:
              const Text("Are you sure you want to delete the selected items?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _handleDeleteSelectedItems();
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<DataProfileProvider>().uid;
    final username = context.read<DataProfileProvider>().username;
    return Scaffold(
      backgroundColor: colorbase,
      appBar: AppBar(
        backgroundColor: colorbase,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Text(
              "$username`s C A R T",
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('cart')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error loading data.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> cartDocuments =
                querySnapshot.docs;

            if (cartDocuments.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            cartItems = cartDocuments.map((document) {
              Map<String, dynamic> data = document.data();
              data['documentId'] = document.id;

              return data;
            }).toList();

            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(color: colorbase),
                    child: Column(
                      children: cartItems.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final Map<String, dynamic> cartItem = entry.value;

                        return Container(
                          decoration: BoxDecoration(
                            color: selectedItems.contains(index)
                                ? Colors.blue
                                : Colors.grey[700],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                value: selectedItems.contains(index),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      selectedItems.add(index);
                                    } else {
                                      selectedItems.remove(index);
                                    }
                                  });
                                },
                                activeColor: Colors.white,
                              ),
                              SizedBox(
                                width: 120,
                                height: 90,
                                child: Image.network(
                                  cartItem['gambarsuplemen'] ?? '',
                                ),
                              ),
                              SizedBox(
                                width: 125,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem['namasuplemen'] ?? '',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Rp ${cartItem['hargasuplemen']?.toString() ?? ''}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Color(0xffb28242c)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Rp ${cartItems.fold<double>(
                                  0,
                                  (previousValue, cartItem) =>
                                      previousValue +
                                      (cartItem['hargasuplemen'] as num? ??
                                          0.0),
                                ).toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 199, 103, 216),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await _showCheckoutConfirmationDialog();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
