import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/coffee_entry.dart';

class NewCoffeeEntryScreen extends StatefulWidget {
  const NewCoffeeEntryScreen({super.key});

  @override
  State<NewCoffeeEntryScreen> createState() => _NewCoffeeEntryScreenState();
}

class _NewCoffeeEntryScreenState extends State<NewCoffeeEntryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String temp = 'Hot';
  int rating = 0;
  File? image;
  bool isImageConfirmed = false;

  @override
  void dispose() {
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource src) async {
    final picked = await ImagePicker().pickImage(source: src);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
        isImageConfirmed = false;
      });
    }
  }

  Future<void> confirmDeleteImage() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Remove Image"),
        content: const Text("Are you sure you want to remove this image?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Remove", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        image = null;
        isImageConfirmed = false;
      });
    }
  }

  Widget buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        return IconButton(
          icon: Icon(
            i < rating ? Icons.star : Icons.star_border,
            color: Colors.black,
          ),
          onPressed: () => setState(() => rating = i + 1),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "New Coffee Entry",
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5AB), Color(0xFFD7A86E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kToolbarHeight + 10),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Coffee Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Coffee Temperature"),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Hot',
                              groupValue: temp,
                              onChanged: (v) => setState(() => temp = v!),
                            ),
                            const Text('Hot'),
                            Radio<String>(
                              value: 'Iced',
                              groupValue: temp,
                              onChanged: (v) => setState(() => temp = v!),
                            ),
                            const Text('Iced'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("Rating"),
                        buildStars(),
                        const SizedBox(height: 10),
                        TextField(
                          controller: notesController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Add Photo"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera_alt),
                              label: const Text("Camera"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white38,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library),
                              label: const Text("Gallery"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                        if (image != null) ...[
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: confirmDeleteImage,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            value: isImageConfirmed,
                            onChanged: (v) => setState(() => isImageConfirmed = v!),
                            title: const Text("Confirm this image"),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (image == null || !isImageConfirmed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Confirm image first.")),
                                );
                              } else {
                                final newEntry = CoffeeEntry(
                                  name: nameController.text,
                                  temperature: temp,
                                  rating: rating,
                                  notes: notesController.text,
                                  image: image!,
                                  date: DateTime.now(),
                                );
                                Navigator.pop(context, newEntry);
                              }
                            },
                            icon: const Icon(Icons.coffee),
                            label: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
