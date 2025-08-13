import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'login.dart';

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

class BookManager extends StatefulWidget {
  const BookManager({super.key});

  @override
  State<BookManager> createState() => _BookManagerState();
}

class _BookManagerState extends State<BookManager> {
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

  void _editBook(int index) {
    final book = books[index];
    final editTitleController = TextEditingController(text: book.title);
    final editAuthorController = TextEditingController(text: book.author);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 209, 231, 249),
        title: const Text('Edit Book'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: CustomTextField(
                controller: editTitleController,
                labelText: "Book Title",
              ),
            ),
            SizedBox(
              width: 300,
              child: CustomTextField(
                controller: editAuthorController,
                labelText: "Author Name",
              ),
            ),
          ],
        ),
        actions:[
          TextButton(
        
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
                child:  Text('Cancel'),
          ),
          TextButton(
           
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {
              final newTitle = editTitleController.text.trim();
              final newAuthor = editAuthorController.text.trim();

              if (newTitle.isNotEmpty && newAuthor.isNotEmpty) {
                setState(() {
                  books[index] = Book(
                    title: newTitle,
                    author: newAuthor,
                    color: book.color,
                  );
                });
                Navigator.of(context).pop();
              }
            },

             child: Text('Save'),
          ),
        ],
      ),
    );
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
        title: const Text('Book Management System'),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'poppins',
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
                  child: Text(
                    'Welcome to the Book Management System',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 112, 116, 122),
                      fontFamily: 'poppins',
                    ),
                  ),
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
          Expanded(
            child: books.isEmpty
                ? const Center(child: Text('No books added yet.'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12),
                        child: Slidable(
                          key: ValueKey(book.title),
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    books.removeAt(index);
                                  });
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 242, 86, 74),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(book.title),
                            subtitle: Text('by ${book.author}'),
                            tileColor: book.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              color: const Color.fromARGB(255, 70, 70, 70),
                              onPressed: () => _editBook(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Icon(Icons.logout, color: Colors.white),
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
