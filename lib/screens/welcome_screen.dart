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
                Text(
                  'CAFÉ',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 60,
                    color: Colors.brown[800],
                    letterSpacing: 8,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        color: Colors.brown.withOpacity(0.18),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '“Start your day, one cup at a time.”',
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.brown[700],
                    letterSpacing: 1.1,
                  ),
                ),

                const SizedBox(height: 120),

                SizedBox(
                  width: 220,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CoffeeHomeScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.coffee,
                      color: Colors.brown[800],
                      size: 26,
                    ),
                    label: Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22,
                        color: Colors.brown[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    style:
                        ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          elevation: 6,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.brown[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(
                              color: Colors.brown,
                              width: 1.5,
                            ),
                          ),
                        ).copyWith(
                          overlayColor: MaterialStateProperty.all(
                            Colors.brown.withOpacity(0.08),
                          ),
                        ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
