import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final Color color;

  Book({
    required this.title,
    required this.author,
    required this.color,
  });
}

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final List<Book> books = [];
  Color? _selectedColor;

  final List<Color> colorOptions = [
    const Color.fromARGB(255, 143, 82, 82),
    const Color.fromARGB(255, 180, 220, 220),
    const Color.fromARGB(255, 51, 143, 120),
    const Color.fromARGB(255, 59, 178, 120),
    const Color.fromARGB(255, 216, 182, 182),
  ];

  void _addBook() {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();

    if (title.isNotEmpty && author.isNotEmpty && _selectedColor != null) {
      setState(() {
        books.add(Book(title: title, author: author, color: _selectedColor!));
        _titleController.clear();
        _authorController.clear();
        _selectedColor = null;
      });
    }
  }

  Widget _buildColorSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: colorOptions.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = color;
              });
            },
            child: Card(
              color: color,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: _selectedColor == color
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SizedBox(width: 60, height: 60),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.black),
         onPressed: () {
           Navigator.pushReplacement(
             context,
             MaterialPageRoute(builder: (context) => const BookManager()),
           );
         }
         ),
        title: const Text(
          'Add Book',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                CustomTextField(
                  controller: _titleController,
                  labelText: "Enter Book Title",
                ),
                CustomTextField(
                  controller: _authorController,
                  labelText: "Enter Author Name",
                ),
                _buildColorSelector(),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 137, 206, 228),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: _addBook,
                  child: const Text(
                    'Add Book',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
     
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color.fromARGB(255, 201, 221, 234),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
