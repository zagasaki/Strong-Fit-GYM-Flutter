import 'package:flutter/material.dart';

class MembershipDetail extends StatelessWidget {
  final String title;
  final String description;
  final String originalPrice;
  final String discountedPrice;
  final List<String> features;

  const MembershipDetail({
    Key? key,
    required this.title,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.near_me_rounded,
                    color: Colors.amber[400],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.lightGreenAccent,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        color: Colors.grey[700],
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      discountedPrice,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Body
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Column(
              children: features.map((feature) {
                return Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.amber[400],
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      feature,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  String? selectedMembership;
  bool isPurchased = false; // Menyimpan status pembelian
  DateTime? startDate;
  DateTime? endDate;

  void purchaseMembership() {
    // Simulasi pembelian
    setState(() {
      isPurchased = true;
      startDate = DateTime.now();
      endDate = startDate!
          .add(const Duration(days: 30)); // Contoh: Masa aktif 30 hari
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        decoration: const BoxDecoration(color: Colors.black87),
        child: Column(
          children: [
            // Content1
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: 100,
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text(
                        "Current Status",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Start Date",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "End Date",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  const Column(
                    children: [
                      Text(":", style: TextStyle(color: Colors.white)),
                      Text(":", style: TextStyle(color: Colors.white)),
                      Text(":", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    width: 144,
                  ),
                  Column(
                    children: [
                      Text(isPurchased ? "Active" : "None",
                          style: TextStyle(
                              color: isPurchased
                                  ? Colors.green
                                  : Colors.white)), // Status aktif
                      Text(
                          isPurchased
                              ? startDate!.toString().split(' ')[0]
                              : "-",
                          style: TextStyle(
                              color: isPurchased
                                  ? Colors.green
                                  : Colors.white)), // Tanggal mulai
                      Text(
                          isPurchased ? endDate!.toString().split(' ')[0] : "-",
                          style: TextStyle(
                              color: isPurchased
                                  ? Colors.green
                                  : Colors.white)), // Tanggal berakhir
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Content2
            MembershipDetail(
              title: selectedMembership ?? "Pilih Paket",
              description: "Deskripsi Paket Anda",
              originalPrice: "Harga Asli",
              discountedPrice: "Harga Diskon",
              features: const [
                "Fitur 1",
                "Fitur 2",
                "Fitur 3",
                // ... (Tambahkan fitur sesuai kebutuhan)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // Pilihan Paket Keanggotaan
            Column(
              children: [
                const Text(
                  "Pilih Paket Keanggotaan:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Gold Membership",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<String>(
                    value: "Gold Membership",
                    groupValue: selectedMembership,
                    onChanged: (value) {
                      setState(() {
                        selectedMembership = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Silver Membership",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<String>(
                    value: "Silver Membership",
                    groupValue: selectedMembership,
                    onChanged: (value) {
                      setState(() {
                        selectedMembership = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            // Tombol Beli Paket Member
            ElevatedButton(
              onPressed: () {
                if (selectedMembership != null) {
                  purchaseMembership();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Pilih Paket Member"),
                        content: const Text(
                            "Silakan pilih paket member terlebih dahulu."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Beli Paket Member"),
            ),
          ],
        ),
      ),
    );
  }
}
