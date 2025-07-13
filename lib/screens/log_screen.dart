import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/coffee_entry.dart';

class CoffeeLogScreen extends StatefulWidget {
  final List<CoffeeEntry> entries;
  const CoffeeLogScreen({super.key, required this.entries});

  @override
  State<CoffeeLogScreen> createState() => _CoffeeLogScreenState();
}

class _CoffeeLogScreenState extends State<CoffeeLogScreen> {
  String filter = 'All'; // Default filter now set to 'All'

  @override
  Widget build(BuildContext context) {
    final filtered = widget.entries
        .where((e) => filter == 'All' || e.temperature == filter)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3E5AB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Coffee Log',
          style: GoogleFonts.montserrat(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Filter buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'All',
                      groupValue: filter,
                      onChanged: (v) => setState(() => filter = v!),
                    ),
                    const Text('All', style: TextStyle(fontSize: 18)),
                    Radio<String>(
                      value: 'Hot',
                      groupValue: filter,
                      onChanged: (v) => setState(() => filter = v!),
                    ),
                    const Text('Hot', style: TextStyle(fontSize: 18)),
                    Radio<String>(
                      value: 'Iced',
                      groupValue: filter,
                      onChanged: (v) => setState(() => filter = v!),
                    ),
                    const Text('Iced', style: TextStyle(fontSize: 18)),
                  ],
                ),

                const SizedBox(height: 10),

                // Entry count
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Entries: ${filtered.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Entry list
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(
                          child: Text(
                            'No coffee entries found for selected filter.',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (ctx, i) {
                            final e = filtered[i];
                            return GestureDetector(
                              onTap: () => _showEntryDetails(context, e),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        e.image,
                                        width: 70,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${_month(e.date.month)} ${e.date.day}, ${e.date.year}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: List.generate(5, (idx) {
                                              return Icon(
                                                idx < e.rating
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                size: 18,
                                                color: Colors.black,
                                              );
                                            }),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '“${e.notes}”',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEntryDetails(BuildContext context, CoffeeEntry e) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(e.image, height: 150, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(
              e.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("${_month(e.date.month)} ${e.date.day}, ${e.date.year}"),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => Icon(
                  i < e.rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '"${e.notes}"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  String _month(int m) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[m - 1];
  }
}
