import 'package:flutter/material.dart';
import 'package:basic/style/style.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrainerPage(),
    );
  }
}

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  String searchText = '';
  List<TrainerData> searchResults = [];

  final List<TrainerData> trainers = [
    TrainerData(
      name: "James Doe",
      gym: "Trainer Gym",
      experience: "8 Years",
      rating: 95,
      asset: "Trainer1.jpeg",
    ),
    TrainerData(
      name: "Richard",
      gym: "Trainer Gym",
      experience: "10 Years",
      rating: 90,
      asset: "Trainer2.jpeg",
    ),
    TrainerData(
      name: "Adam Smith",
      gym: "Trainer Gym",
      experience: "20 Years",
      rating: 100,
      asset: "Trainer3.jpeg",
    ),
    TrainerData(
      name: "John Doe",
      gym: "Trainer Gym",
      experience: "12 Years",
      rating: 98,
      asset: "Trainer4.jpeg",
    ),
    TrainerData(
      name: "Sarah Johnson",
      gym: "FitLife",
      experience: "15 Years",
      rating: 92,
      asset: "Trainer5.jpeg",
    ),
    TrainerData(
      name: "Emily Wilson",
      gym: "PowerFit",
      experience: "18 Years",
      rating: 97,
      asset: "Trainer6.jpeg",
    ),
    TrainerData(
      name: "Michael Brown",
      gym: "FitnessPro",
      experience: "7 Years",
      rating: 89,
      asset: "Trainer7.jpeg",
    ),
    TrainerData(
      name: "Sophia Davis",
      gym: "Elite Fitness",
      experience: "9 Years",
      rating: 96,
      asset: "Trainer8.jpeg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: colorbase,
              child: TextField(
                style: const TextStyle(color: Colors.white),
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
                ),
                onChanged: (text) {
                  setState(() {
                    searchText = text;
                    searchResults = trainers
                        .where((trainer) => trainer.name
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: colorbase),
              child: ListView.builder(
                itemCount:
                    searchText.isEmpty ? trainers.length : searchResults.length,
                itemBuilder: (context, index) {
                  final trainer = searchText.isEmpty
                      ? trainers[index]
                      : searchResults[index];
                  return TrainerCard(trainerData: trainer);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainerData {
  final String name;
  final String gym;
  final String experience;
  final int rating;
  final String asset;

  TrainerData({
    required this.name,
    required this.gym,
    required this.experience,
    required this.rating,
    required this.asset,
  });
}

class TrainerCard extends StatelessWidget {
  final TrainerData trainerData;

  const TrainerCard({super.key, required this.trainerData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image.asset(
            "assets/${trainerData.asset}",
            width: screenWidth * 0.4, // Adjust as needed
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainerData.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04, // Adjust as needed
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  trainerData.gym,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/trainerlogo.png",
                            width: screenWidth * 0.05, // Adjust as needed
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(trainerData.experience),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up),
                          Text('${trainerData.rating.toString()}%'),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 15),
                  child: const Row(
                    children: [
                      Icon(Icons.contact_page),
                      Text("Contact"),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
