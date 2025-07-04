import 'dart:io';

class CoffeeEntry {
  final String name;
  final String temperature;
  final int rating;
  final String notes;
  final File image;
  final DateTime date;
  String? customQuote;

  CoffeeEntry({
    required this.name,
    required this.temperature,
    required this.rating,
    required this.notes,
    required this.image,
    required this.date,
    this.customQuote,
  });
}
