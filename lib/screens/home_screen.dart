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
          'Coffee Journal',
          style: GoogleFonts.montserrat(
            fontSize: 26,
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
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Life begins\nafter coffee.',
                    style: GoogleFonts.lora(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown[900],
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 35),
                _buildModernMenuButton(
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
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFDE8C9), Color(0xFFD7A86E)],
                  ),
                ),
                const SizedBox(height: 18),
                _buildModernMenuButton(
                  icon: Icons.insert_drive_file,
                  text: 'View My Coffee Log',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoffeeLogScreen(entries: _entries),
                    ),
                  ),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD7A86E), Color(0xFFF3E5AB)],
                  ),
                ),
                const SizedBox(height: 18),
                _buildModernMenuButton(
                  icon: Icons.chat_bubble,
                  text: 'Coffee Quotes',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            InspirationalQuoteGalleryScreen(entries: _entries),
                      ),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD7A86E), Color(0xFFFDE8C9)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onPressed,
          splashColor: Colors.brown.withOpacity(0.25),
          highlightColor: Colors.brown.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[100],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, color: Colors.brown[700], size: 28),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      color: Colors.brown[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
