import 'package:basic/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Rest extends StatefulWidget {
  const Rest({Key? key}) : super(key: key);

  @override
  State<Rest> createState() => _RestState();
}

class _RestState extends State<Rest> {
  @override
  Widget build(BuildContext context) {
    final provTugas2 = context.watch<DataProfileProvider>();
    final picked = provTugas2.dataCurrentdate;
    final formatteddate = DateFormat("MMMM dd").format(picked);
    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month, now.day);
    final result = (nowDate == picked) ? 'Today' : 'on $formatteddate';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FoodRecommendationSection(result: result),
            const SizedBox(height: 10),
            RestDaySection(result: result),
          ],
        ),
      ),
    );
  }
}

class FoodRecommendationSection extends StatelessWidget {
  const FoodRecommendationSection({required this.result, Key? key})
      : super(key: key);

  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Food Recommendation $result",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AutofillHints.addressCity,
            ),
          ),
          const SizedBox(height: 10),
          const FoodItemRow(
            image: "assets/longbean.png",
            name: "Long bean",
            amount: "200gr",
          ),
          const SizedBox(height: 10),
          const FoodItemRow(
            image: "assets/chickenbreast.png",
            name: "Chicken Breast",
            amount: "200gr",
          ),
          const SizedBox(height: 10),
          const FoodItemRow(
            image: "assets/oats.png",
            name: "Oats",
            amount: "300gr",
          ),
        ],
      ),
    );
  }
}

class RestDaySection extends StatelessWidget {
  const RestDaySection({required this.result, Key? key}) : super(key: key);

  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(10),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  "$result Is a Rest Day",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: AutofillHints.addressCity,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/rest.png",
                  width: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemRow extends StatelessWidget {
  const FoodItemRow(
      {required this.image, required this.name, required this.amount, Key? key})
      : super(key: key);

  final String image;
  final String name;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 40,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
