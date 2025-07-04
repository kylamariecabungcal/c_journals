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
      "Behind every successful person is a substantial amount of coffee.",
      "Perk up and push through."
    ];

    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % fallbackQuotes.length;
    return fallbackQuotes[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isEmpty) {
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
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
              ),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.file(
                        File(entry.image.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '“$quote”',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      fontSize: 26,
                      color: Colors.brown[900],
                      fontWeight: FontWeight.w500,
                    ),
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
