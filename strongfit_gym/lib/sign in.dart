import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background1.jpg"),
                  fit: BoxFit.fill)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Track Your Progress",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: AutofillHints.countryName,
                ),
              ),
              Text(
                "Reach give you a journal to track your progress and compare your old and new self",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: AutofillHints.countryName,
                ),
              )
            ],
          )),
    );
  }
}
