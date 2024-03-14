import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:basic/style/style.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  List<EventModel> details = [];
  List<EventModel> filteredTrainerList = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('trainer_data').get();
    setState(() {
      details =
          data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
      filteredTrainerList = details;
    });
  }

  void filterTrainer(String query) {
    setState(() {
      filteredTrainerList = details
          .where((trainer) =>
              trainer.namatrainer.toLowerCase().contains(query.toLowerCase()) ||
              trainer.jenistrainer.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: colorbase,
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: colorbase,
              child: TextField(
                controller: search,
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
                onChanged: (query) {
                  filterTrainer(query); // Fixed: Call filterTrainer with query
                },
              ),
            ),
          ),
          for (var trainer in filteredTrainerList)
            Container(
              color: colorbase,
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.network(
                    trainer.gambartrainer,
                    width: screenWidth * 0.4, // Adjust as needed
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainer.namatrainer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04, // Adjust as needed
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          trainer.jenistrainer,
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
                                    width:
                                        screenWidth * 0.05, // Adjust as needed
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(trainer.pengalaman),
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
                                  Text('${trainer.like.toString()}%'),
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
            )
        ],
      ),
    ));
  }
}
