import 'package:basic/Provider/MyProvider.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:basic/Page/suplemen_page/SuplemenModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuplemenDetailPage extends StatefulWidget {
  final EventModel suplemen;

  const SuplemenDetailPage({Key? key, required this.suplemen})
      : super(key: key);

  @override
  _SuplemenDetailPageState createState() => _SuplemenDetailPageState();
}

class _SuplemenDetailPageState extends State<SuplemenDetailPage> {
  int quantity = 1;
  TextEditingController commentController = TextEditingController();
  double userRating = 0.0; // Default rating value
  List<Map<String, dynamic>> ratings = [];

  Future<void> _addToCart() async {
    try {
      final uid = context.read<DataProfileProvider>().uid;

      if (uid != null) {
        CollectionReference userCart = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('cart');
        await userCart.add({
          'namasuplemen': widget.suplemen.namasuplemen,
          'jenissuplemen': widget.suplemen.jenissuplemen,
          'hargasuplemen': widget.suplemen.hargasuplemen,
          'gambarsuplemen': widget.suplemen.gambarsuplemen,
          'quantity': quantity,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added to cart'),
          ),
        );
      } else {
        print('User not signed in');
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> _submitRatingAndComment() async {
    try {
      final uid = context.read<DataProfileProvider>().uid;

      if (uid != null &&
          userRating != 0.0 &&
          commentController.text.isNotEmpty) {
        CollectionReference ratingsCollection =
            FirebaseFirestore.instance.collection('ratings');
        await ratingsCollection.add({
          'productId': widget.suplemen.id,
          'userId': uid,
          'rating': userRating,
          'comment': commentController.text,
          'username': context.read<DataProfileProvider>().username,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rating and Comment submitted'),
          ),
        );

        // Refresh ratings after submission
        await loadRatings();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide both rating and comment'),
          ),
        );
      }
    } catch (e) {
      print('Error submitting rating and comment: $e');
    }
  }

  Future<void> loadRatings() async {
    try {
      final productId = widget.suplemen.id;
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('ratings')
              .where('productId', isEqualTo: productId)
              .get();

      ratings = querySnapshot.docs.map((document) => document.data()).toList();
      setState(() {});
    } catch (e) {
      print('Error fetching ratings: $e');
    }
  }

  Future<void> _showRatingAndCommentAlert() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rating and Comment"),
          content: Column(
            children: [
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    userRating = rating;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Your Comment',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitRatingAndComment();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadRatings();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colorbase,
      appBar: AppBar(
        backgroundColor: colorbase,
        title: Text(
          widget.suplemen.namasuplemen,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.suplemen.gambarsuplemen,
              width: double.infinity,
              height: screenHeight * 0.3,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type: ${widget.suplemen.jenissuplemen}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: ${widget.suplemen.hargasuplemen}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.suplemen.deskripsi,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Rating and Comments:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: ratings.map((rating) {
                return ListTile(
                  tileColor: appbarcolor,
                  title: Text(
                    '${rating['username']} - Rating: ${rating['rating']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${rating['comment']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showRatingAndCommentAlert();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Give Rating and Comment",
                style: TextStyle(color: colorbase),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                    color: Colors.white,
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    color: Colors.white,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _addToCart();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: colorbase),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
