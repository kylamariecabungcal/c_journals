import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/coffee_entry.dart'; // Ensure this path is correct

class InspirationalQuoteGalleryScreen extends StatefulWidget {
  final List<CoffeeEntry> entries;

  const InspirationalQuoteGalleryScreen({super.key, required this.entries});

  @override
  State<InspirationalQuoteGalleryScreen> createState() =>
      _InspirationalQuoteGalleryScreenState();
}

class _InspirationalQuoteGalleryScreenState
    extends State<InspirationalQuoteGalleryScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  String _generateQuote(CoffeeEntry entry) {
    if (entry.customQuote != null && entry.customQuote!.trim().isNotEmpty) {
      return entry.customQuote!;
    }

    final List<String> fallbackQuotes = [
      "Coffee is always a good idea.",
      "But first, coffee.",
      "Espresso yourself!",
      "Life happens. Coffee helps.",
      "Keep calm and drink coffee.",
      "Caffeine & kindness.",
      "Sippin' joy, one cup at a time.",
      "A yawn is a silent scream for coffee.",
      "Coffee: because adulting is hard.",
      "Rise and grind!",
      "One sip at a time.",
      "A brew-tiful way to start the day.",
      "Happiness is a cup of coffee.",
      "Fueled by coffee and dreams.",
      "Coffee: my hot friend I was telling you about.",
      "Love you a latte.",
      "Mornings are better with coffee.",
      "Coffee — the most important meal of the day.",
      "Brew, sip, repeat.",
      "Start your day with a coffee and a smile.",
      "May your coffee be strong and your dreams stronger.",
      "Coffee teaches us: good things take time to brew.",
      "Perk up and push through.",
      "Coffee: the gasoline of life.",
      "Adventure in life is good; consistency in coffee even better.",
      "Coffee is a hug in a mug.",
      "May your coffee kick in before reality does.",
      "Coffee: because adulting is hard.",
      "Coffee smells like freshly ground heaven.",
      "Coffee and friends make the perfect blend.",
      "Coffee: the most important meal of the day.",
      "Coffee is love made visible.",
      "Coffee is my love language.",
      "Coffee: the foundation of productivity.",
      "Coffee is the answer. Who cares what the question is?",
      "Coffee is the best thing to douse the sunrise with.",
      "Coffee is a language in itself.",
      "Coffee: turning tired into inspired.",
      "Coffee is the best medicine.",
      "Coffee is the best part of waking up.",
      "Coffee is the best way to start the day.",
      "Coffee is the best way to end the day.",
      "Coffee is the best way to take a break.",
      "Coffee is the best way to relax.",
      "Coffee is the best way to celebrate.",
      "Coffee is the best way to connect.",
      "Coffee is the best way to create.",
      "Coffee is the best way to dream.",
      "Coffee is the best way to love.",
      "Coffee is the best way to think.",
      "Coffee is the best way to work.",
      "Coffee is the best way to write.",
      "Coffee is the best way to read.",
      "Coffee is the best way to learn.",
      "Coffee is the best way to grow.",
      "Coffee is the best way to live.",
    ];

    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % fallbackQuotes.length;
    return fallbackQuotes[randomIndex];
  }

  // --- Ibalik ang _showEditQuoteDialog method ---
  void _showEditQuoteDialog(CoffeeEntry entry) async {
    final controller = TextEditingController(text: entry.customQuote ?? "");
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save/Edit Quote'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Enter your coffee quote',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        entry.customQuote = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDE8C9),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.brown),
          title: Text(
            'Coffee Quotes',
            style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFDE8C9), Color(0xFFD7A86E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Center(
            child: Text(
              'No coffee entries available.',
              style: TextStyle(fontSize: 25, color: Colors.black87),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDE8C9),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.brown),
        title: const Text(
          'Coffee Quotes',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDE8C9), Color(0xFFD7A86E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.entries.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final entry = widget.entries[index];
            final quote = _generateQuote(entry);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 320,
                    height: 420,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.brown, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.18),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: SizedBox(
                            height: 180,
                            width: 280,
                            child: Image.file(
                              File(entry.image.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '“$quote”',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lora(
                              fontSize: 28,
                              color: Colors.brown[800],
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.brown[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Coffee Journal',
                            style: GoogleFonts.pacifico(
                              color: Colors.brown[400],
                              fontSize: 18,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                  label: Text(
                    entry.customQuote == null || entry.customQuote!.isEmpty
                        ? 'Save Quote'
                        : 'Edit Quote',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[200],
                    foregroundColor: Colors.brown[900],
                    minimumSize: const Size(160, 48),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
