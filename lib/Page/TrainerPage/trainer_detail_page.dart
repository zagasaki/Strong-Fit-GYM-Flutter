import 'package:basic/style/style.dart';
import 'package:flutter/material.dart';
import 'TrainerModel.dart'; // Import your TrainerModel class

class TrainerDetailPage extends StatefulWidget {
  final EventModel trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  @override
  _TrainerDetailPageState createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title:
            const Text('Trainer Detail', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: colorbase, // Adjust color as needed
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.trainer.gambartrainer,
              width: screenWidth, // Adjust as needed
              height: screenWidth * 0.6, // Adjust as needed
            ),
            const SizedBox(height: 20),
            Text(
              widget.trainer.namatrainer,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.06, // Adjust as needed
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              widget.trainer.jenistrainer,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Age: ${widget.trainer.pengalaman} Year',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
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
                      const SizedBox(width: 8),
                      Text(widget.trainer.pengalaman),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(Icons.thumb_up),
                      Text('50%'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contact_page, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Contact", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
