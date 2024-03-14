import 'package:basic/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exercise1 extends StatefulWidget {
  const Exercise1({super.key});

  @override
  State<Exercise1> createState() => _Exercise1State();
}

class _Exercise1State extends State<Exercise1> {
  bool? isTaskCompleted;
  DateTime? lastSavedDate;
  bool isTask1Completed = false;
  bool isTask2Completed = false;
  bool isTask3Completed = false;

  @override
  void initState() {
    super.initState();
    // Memeriksa tanggal terakhir data disimpan
    loadLastSavedDate();
    // Memeriksa status tugas dari SharedPreferences
    loadTaskStatus();
  }

  void loadTaskStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil status task yang disimpan di SharedPreferences
    final taskStatus = prefs.getBool('taskStatus');
    setState(() {
      isTaskCompleted = taskStatus;
    });

    // Muat status tugas individu
    isTask1Completed = prefs.getBool('isTask1Completed') ?? false;
    isTask2Completed = prefs.getBool('isTask2Completed') ?? false;
    isTask3Completed = prefs.getBool('isTask3Completed') ?? false;
  }

  void loadLastSavedDate() async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil tanggal terakhir data disimpan di SharedPreferences
    final savedDateMilliseconds = prefs.getInt('lastSavedDate') ?? 0;
    if (savedDateMilliseconds > 0) {
      lastSavedDate =
          DateTime.fromMillisecondsSinceEpoch(savedDateMilliseconds);
    }
  }

  void saveTaskStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    // Simpan status tugas keseluruhan ke dalam SharedPreferences
    prefs.setBool('taskStatus', value);
    // Simpan tanggal saat ini sebagai tanggal terakhir data disimpan
    prefs.setInt('lastSavedDate', DateTime.now().millisecondsSinceEpoch);

    // Simpan status tugas individu
    prefs.setBool('isTask1Completed', isTask1Completed);
    prefs.setBool('isTask2Completed', isTask2Completed);
    prefs.setBool('isTask3Completed', isTask3Completed);
  }

  void resetDataIfNeeded() {
    // Jika tanggal terakhir data disimpan tidak ada atau berbeda dari tanggal saat ini, reset data
    final now = DateTime.now();
    if (lastSavedDate == null || lastSavedDate?.day != now.day) {
      isTaskCompleted = false; // Reset status tugas
      lastSavedDate = now; // Update tanggal terakhir data disimpan
      saveTaskStatus(isTaskCompleted!); // Simpan data ulang
    }
    if (lastSavedDate == null || lastSavedDate?.day != now.day) {
      isTaskCompleted = false; // Reset status tugas
      // Set nilai untuk tugas-tugas tertentu
      isTask1Completed = false;
      isTask2Completed = false;
      isTask3Completed = false;
      lastSavedDate = now; // Update tanggal terakhir data disimpan
      saveTaskStatus(isTaskCompleted!); // Simpan data ulang
      // Periksa jika semua tugas sudah selesai
      if (isTask1Completed && isTask2Completed && isTask3Completed) {
        // Tampilkan popup
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  const Text('Selamat! Anda telah menyelesaikan semua tugas.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provTugas2 = context.watch<DataProfileProvider>();
    final picked = provTugas2.dataCurrentdate;
    final formatteddate = DateFormat("MMMM dd").format(picked);
    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month, now.day);
    final result = (nowDate == picked) ? 'Today' : 'on $formatteddate';
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Food Recommendation $result",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AutofillHints.addressCity),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/rice.png",
                    width: 50,
                  ),
                  const Text(
                    "Rice",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "100gr",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/manuk.png",
                    width: 50,
                  ),
                  const Text(
                    "Chicken Wings",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "50gr",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/brocoli.png",
                    width: 50,
                  ),
                  const Text(
                    "Brocoli",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "200gr",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Your Task $result",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.addressCity),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/squad.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      "Squad",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "30",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "reps",
                      style: TextStyle(color: Colors.grey),
                    ),
                    nowDate == picked
                        ? Checkbox(
                            value: isTask1Completed,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isTask1Completed = newValue!;
                                saveTaskStatus(newValue);
                              });
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/dumblepress.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      "Dumble Press",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "30",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "reps",
                      style: TextStyle(color: Colors.grey),
                    ),
                    nowDate == picked
                        ? Checkbox(
                            value: isTask2Completed,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isTask2Completed = newValue!;
                                saveTaskStatus(newValue);
                              });
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/situp.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      "Sit Up",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "30",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "reps",
                      style: TextStyle(color: Colors.grey),
                    ),
                    nowDate == picked
                        ? Checkbox(
                            value: isTask3Completed,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isTask3Completed = newValue!;
                                saveTaskStatus(newValue);
                              });
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
        provTugas2.dataCurrentdate == picked
            ? ElevatedButton(
                onPressed: () {
                  if (isTask1Completed &&
                      isTask2Completed &&
                      isTask3Completed) {
                    // Tampilkan popup
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              'Selamat! Anda telah menyelesaikan semua tugas.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text('Masih ada task yang belum selesai'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Cek Hasil yang anda raih"))
            : const SizedBox()
      ],
    );
  }
}
