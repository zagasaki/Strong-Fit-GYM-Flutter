import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb28242c),
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
                )),
            const Text(
              "C A R T",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //Main
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.black87),
              child: Column(
                children: [
                  //Produk
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[700]),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 120,
                              height: 90,
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY-xFPkslDc7wPZaCSZoKF_ZvKe4EIGA6jQQ&usqp=CAU",
                              ),
                            ),
                            const SizedBox(
                                width: 125,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NTech Whey 500gr",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text("Rp 440.000",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.remove_circle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "1",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),

            //Total belanjaan
            Container(
              decoration: const BoxDecoration(color: Color(0xffb28242c)),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(color: Colors.grey[350]),
                      ),
                      const Text("Rp 440.000",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
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
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
