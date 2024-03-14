import 'package:basic/Page/Login&Register_page/login_page.dart';
import 'package:basic/Page/Login&Register_page/register_page.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Welcome to Strongfit",
                    style: TextStyle(
                      fontSize: 0.08 * screenWidth,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.04 * screenWidth,
                ),
                Text(
                  "Chose your favorite fitness trainer",
                  style: TextStyle(
                      fontSize: 0.04 * screenWidth,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "and never have a bad workout again.",
                  style: TextStyle(
                      fontSize: 0.04 * screenWidth,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 0.04 * screenWidth,
                ),

                // Button "Sign Up"
                SizedBox(
                  width: 0.70 * screenWidth,
                  height: 0.12 * screenWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.amber,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 0.05 * screenWidth,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.015 * screenWidth,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.06 * screenWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
