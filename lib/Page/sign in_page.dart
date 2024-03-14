import 'package:basic/Page/Login&Register_page/login_page.dart';
import 'package:basic/Page/Login&Register_page/register_page.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background2.jpg"),
                  fit: BoxFit.fill)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Track Your Progress",
                      style: TextStyle(
                        fontSize: 0.1 * screenWidth, // Responsif
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 0.05 * screenHeight, // Responsif
                    ),
                    Text(
                      "Reach give you a journal to track your",
                      style: TextStyle(
                          fontSize: 0.03 * screenWidth, // Responsif
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "progress and compare your old and new self",
                      style: TextStyle(
                          fontSize: 0.03 * screenWidth, // Responsif
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 0.1 * screenHeight, // Responsif
                    ),

                    // Sign in button
                    SizedBox(
                      width: 0.65 * screenWidth, // Responsif
                      height: 0.1 * screenHeight, // Responsif
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.amber,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 0.04 * screenWidth, // Responsif
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.05 * screenHeight, // Responsif
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 0.03 * screenWidth, // Responsif
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 0.03 * screenWidth, // Responsif
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.1 * screenHeight, // Responsif
                    )
                  ],
                ),
              )),
        ));
  }
}
