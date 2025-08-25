import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bookapp/colors.dart';
import 'package:bookapp/local_storage.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}
class _LibraryScreenState extends State<LibraryScreen> {
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() {
    final storedBooks = StorageManager.getBooks();
    setState(() {
      books = storedBooks;
    });
  }

  void _openEditScreen(Map<String, dynamic> book, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return EditBookSheet(
          book: book,
          onSave: (updatedBook) {
            setState(() {
              books[index] = updatedBook;
            });
            StorageManager.updateBook(updatedBook);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Manager'),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'poppins',
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "My Books",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: books.isEmpty
                  ? const Center(child: Text("No books added yet"))
                  : GridView.builder(
                      itemCount: books.length,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final book = books[index];

                        final String title = book['title'] ?? '';
                        final String author = book['author'] ?? '';
                        final String imagePath = book['imagePath'] ?? '';
                        final int colorValue = book['color'] ?? 0xFFFFFFFF;

                        return Dismissible(
                          key: Key(imagePath),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Appcolors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              books.removeAt(index);
                              StorageManager.deleteBook(imagePath);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$title deleted')),
                            );
                          },
                          child: GestureDetector(
                            onTap: () => _openEditScreen(book, index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(colorValue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(imagePath),
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: 120,
                                          child: const Center(
                                            
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                         fontWeight: FontWeight.w500 ),
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
          ],
        ),
      ),
    );
  }
}
class EditBookSheet extends StatefulWidget {
  final Map<String, dynamic> book;
  final void Function(Map<String, dynamic>) onSave;

  const EditBookSheet({super.key, required this.book, required this.onSave});

  @override
  State<EditBookSheet> createState() => _EditBookSheetState();
}

class _EditBookSheetState extends State<EditBookSheet> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _typeController;
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book['title']);
    _authorController = TextEditingController(text: widget.book['author']);
    _typeController = TextEditingController(text: widget.book['type']);
    _selectedColor = Color(widget.book['color']);
  }

  void _saveChanges() {
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final updatedBook = {
      'title': _titleController.text,
      'author': _authorController.text,
      'type': _typeController.text,
      'imagePath': widget.book['imagePath'],
      'color': _selectedColor!.value,
    };

    widget.onSave(updatedBook);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Edit Book",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Appcolors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.black),
                ),
              ),
            ),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: "Author",
                labelStyle: TextStyle(color: Appcolors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.black),
                ),
              ),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: "Book Type",
                labelStyle: TextStyle(color: Appcolors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Choose a Color:"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Appcolors.bookColors.map((color) {
                final bool isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 1)
                          : null,
                    ),
                    width: 40,
                    height: 40,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
