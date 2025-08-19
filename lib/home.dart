import 'package:bookapp/add_Screen.dart';
import 'package:flutter/material.dart';
import 'local_storage.dart';


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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

