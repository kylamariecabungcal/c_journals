import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/new_entry_screen.dart';
import 'screens/coffee_log_screen.dart';
import 'screens/quote_screen.dart';
import 'models/coffee_entry.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CoffeeWelcomeScreen(),
        '/home': (context) => const CoffeeHomeScreen(),
        '/new-entry': (context) => const NewCoffeeEntryScreen(),
        '/coffee-log': (context) => const CoffeeLogScreen(),
        // The quote screen needs entries, so you’ll navigate to it manually with data
        // Example:
        // Navigator.push(context, MaterialPageRoute(builder: (_) => InspirationalQuoteGalleryScreen(entries: myEntries)));
      },
    );
  }
}
