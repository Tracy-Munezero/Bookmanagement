import 'dart:io';
import 'dart:ui';

class Book {
  final String title;
  final String author;
  final String type;
  final File image;
  final Color color;

  Book({
    required this.title,
    required this.author,
    required this.type,
    required this.image,
    required this.color,
  });
}