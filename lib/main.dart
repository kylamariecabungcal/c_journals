import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/new_entry_screen.dart';
import 'screens/log_screen.dart';

// model import not needed here

void main() {
  runApp(const MyCoffeeApp());
}

class MyCoffeeApp extends StatelessWidget {
  const MyCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Cove',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: '/',
      routes: {
        '/': (context) => const CoffeeWelcomeScreen(),
        '/home': (context) => const CoffeeHomeScreen(),
        '/new-entry': (context) => const NewCoffeeEntryScreen(),
        '/coffee-log': (context) => CoffeeLogScreen(
          entries: const [],
        ), // Placeholder, should pass entries when navigating
        // The quote screen requires entries, so navigate to it with MaterialPageRoute and pass entries
      },
    );
  }
}
