import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/coffee_entry.dart';
import 'package:google_fonts/google_fonts.dart';

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
    int step = 1;
    if (nameController.text.trim().isNotEmpty &&
        notesController.text.trim().isNotEmpty)
      step = 2;
    if (image != null && isImageConfirmed) step = 3;
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
        title: Text(
          'New Coffee Entry ',
          style: GoogleFonts.montserrat(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Decorative coffee bean background
          Positioned(
            bottom: -30,
            right: -30,
            child: Opacity(
              opacity: 0.10,
              child: Icon(Icons.coffee, size: 220, color: Colors.brown[300]),
            ),
          ),
          Container(
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
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.brown.withOpacity(0.10),
                                  blurRadius: 32,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                _StepProgressIndicator(currentStep: step),
                                const SizedBox(height: 18),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Coffee Name',
                                    labelStyle: GoogleFonts.montserrat(
                                      color: Colors.brown[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.brown[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.brown.shade200,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.brown.shade100,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.coffee,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _sectionDivider(),
                                const SizedBox(height: 18),
                                Text(
                                  "Coffee Temperature",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.brown[800],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Hot',
                                      groupValue: temp,
                                      onChanged: (v) =>
                                          setState(() => temp = v!),
                                    ),
                                    Text(
                                      'Hot',
                                      style: GoogleFonts.lora(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Radio<String>(
                                      value: 'Iced',
                                      groupValue: temp,
                                      onChanged: (v) =>
                                          setState(() => temp = v!),
                                    ),
                                    Text(
                                      'Iced',
                                      style: GoogleFonts.lora(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                _sectionDivider(),
                                const SizedBox(height: 18),
                                Text(
                                  "Rating",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.brown[800],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                buildStars(),
                                const SizedBox(height: 18),
                                _sectionDivider(),
                                const SizedBox(height: 18),
                                TextField(
                                  controller: notesController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Notes',
                                    labelStyle: GoogleFonts.montserrat(
                                      color: Colors.brown[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                    filled: true,
                                    fillColor: Colors.brown[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.brown.shade200,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.brown.shade100,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.notes,
                                      color: Colors.brown,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _sectionDivider(),
                                const SizedBox(height: 18),
                                Text(
                                  "Add Photo",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.brown[800],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          pickImage(ImageSource.camera),
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text("Camera"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[100],
                                        foregroundColor: Colors.brown[900],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          pickImage(ImageSource.gallery),
                                      icon: const Icon(Icons.photo_library),
                                      label: const Text("Gallery"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[100],
                                        foregroundColor: Colors.brown[900],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (image != null) ...[
                                  const SizedBox(height: 20),
                                  Center(
                                    child: GestureDetector(
                                      onTap: confirmDeleteImage,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: Image.file(
                                              image!,
                                              height: 180,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CheckboxListTile(
                                    value: isImageConfirmed,
                                    onChanged: (v) =>
                                        setState(() => isImageConfirmed = v!),
                                    title: Text(
                                      "Confirm this image",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.brown[800],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ],
                                const SizedBox(height: 30),
                                Center(
                                  child: Tooltip(
                                    message: 'Save your coffee entry',
                                    child: _AnimatedSaveButton(
                                      onPressed: () async {
                                        if (image == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please add a photo of your coffee.",
                                              ),
                                            ),
                                          );
                                        } else if (!isImageConfirmed) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please confirm your coffee photo.",
                                              ),
                                            ),
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
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              title: const Text(
                                                'Successfully Saved!',
                                              ),
                                              content: const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 60,
                                              ),
                                            ),
                                          );
                                          await Future.delayed(
                                            const Duration(seconds: 1),
                                          );
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop(); // close dialog
                                          Navigator.pop(context, newEntry);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Section divider widget
Widget _sectionDivider() {
  return Row(
    children: [
      Expanded(child: Divider(color: Colors.brown[200], thickness: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.coffee, color: Colors.brown[300], size: 20),
      ),
      Expanded(child: Divider(color: Colors.brown[200], thickness: 1)),
    ],
  );
}

// Animated Save Button
class _AnimatedSaveButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedSaveButton({required this.onPressed});

  @override
  State<_AnimatedSaveButton> createState() => _AnimatedSaveButtonState();
}

class _AnimatedSaveButtonState extends State<_AnimatedSaveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.coffee),
              label: Text(
                "Save",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                shadowColor: Colors.brown[200],
              ),
              onPressed: widget.onPressed,
            ),
          );
        },
      ),
    );
  }
}

// Step progress indicator widget
class _StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  const _StepProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'label': 'Details', 'icon': Icons.edit},
      {'label': 'Photo', 'icon': Icons.photo_camera},
      {'label': 'Confirm', 'icon': Icons.check_circle},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final isActive = currentStep > i;
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isActive ? Colors.brown[700] : Colors.brown[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? Colors.brown : Colors.brown[200]!,
                  width: 2,
                ),
              ),
              child: Icon(
                steps[i]['icon'] as IconData,
                color: isActive ? Colors.white : Colors.brown[400],
                size: 22,
              ),
            ),
            if (i < steps.length - 1)
              Container(
                width: 36,
                height: 4,
                color: isActive ? Colors.brown[400] : Colors.brown[100],
              ),
          ],
        );
      }),
    );
  }
}
