import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart'; // Make sure this path is correct

class CoffeeWelcomeScreen extends StatelessWidget {
  const CoffeeWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF3E5AB), Color(0xFFD7A86E)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Lottie animation (smaller, above text)
                SizedBox(
                  height: 250,
                  child: Lottie.asset(
                    'assets/coffeesplash.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),

                const SizedBox(height: 12),

                // ✅ App title text
                const Text(
                  'CAFÉ',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w200,
                    color: Colors.brown,
                    letterSpacing: 8,
                  ),
                ),
                const Text(
                  '“Start your day, one cup at a time.”',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Colors.brown,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 200),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CoffeeHomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.brown),
                    ),
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(Colors.brown.withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
