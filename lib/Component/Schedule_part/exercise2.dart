import 'package:basic/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});

  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  bool? isTaskCompleted;
  DateTime? lastSavedDate;
  bool isTask1Completed = false;
  bool isTask2Completed = false;
  bool isTask3Completed = false;
  DateTime? picked;

  @override
  void initState() {
    super.initState();
    // Memeriksa tanggal terakhir data disimpan
    loadLastSavedDate();
    // Memeriksa status tugas dari SharedPreferences
    loadTaskStatus();
    picked = DateTime.now();
  }

  Future<void> showAutoPopup(BuildContext context) async {
    // Tampilkan dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Judul Popup'),
          content: Text('Isi pesan popup di sini.'),
        );
      },
    );

    // Tambahkan penundaan sebelum menutup dialog
    await Future.delayed(const Duration(
        seconds:
            3)); // Ubah angka 3 sesuai dengan waktu yang diinginkan (dalam detik)

    // Tutup dialog secara otomatis
    Navigator.of(context).pop();
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
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Food Recommendation $result",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.addressCity),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/tempe.png",
                    width: 50,
                  ),
                  const Text(
                    "Tempe",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "150gr",
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
                    "assets/telur.png",
                    width: 50,
                  ),
                  const Text(
                    "Eggs",
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
                    "assets/spinach.png",
                    width: 50,
                  ),
                  const Text(
                    "Spinach",
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
                width: 600,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/shoulderpress.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Shoulder Press",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "25",
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
                      "assets/dips.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      "Dips",
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
                      "assets/lateralraise.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      "Lateral Raise",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "25",
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
        nowDate == picked
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
