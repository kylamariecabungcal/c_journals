import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/coffee_entry.dart';
import 'new_entry_screen.dart';
import 'log_screen.dart';
import 'quote_screen.dart';

class CoffeeHomeScreen extends StatefulWidget {
  const CoffeeHomeScreen({super.key});

  @override
  State<CoffeeHomeScreen> createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {
  final List<CoffeeEntry> _entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3E5AB),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'COFFEE JOURNAL',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5AB), Color(0xFFD7A86E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    'assets/coffee.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Life begins\nafter  coffee.',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 35),
                _buildMenuButton(
                  icon: Icons.add,
                  text: 'Add New Coffee Entry',
                  onPressed: () async {
                    final newEntry = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewCoffeeEntryScreen(),
                      ),
                    );
                    if (newEntry != null && newEntry is CoffeeEntry) {
                      setState(() => _entries.add(newEntry));
                    }
                  },
                ),
                const SizedBox(height: 14),
                _buildMenuButton(
                  icon: Icons.insert_drive_file,
                  text: 'View My Coffee Log',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoffeeLogScreen(entries: _entries),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _buildMenuButton(
                  icon: Icons.chat_bubble,
                  text: 'Coffee Quotes',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InspirationalQuoteGalleryScreen(
                          entries: _entries,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
