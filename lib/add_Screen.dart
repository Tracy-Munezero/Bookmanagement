import 'package:bookapp/colors.dart';
import 'package:bookapp/home.dart';
import 'package:bookapp/library_screen.dart';
import 'package:bookapp/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  File? _selectedImage;
  final List<Book> books = [];
  Color? _selectedColor;
  final List<Color> _availableColors = [
  const Color(0xffE7B3B3),
  const Color(0xff91B6CD),
  const Color(0xff8D8CB3),
  const Color(0xffE6C9DD),
  const Color(0xffEAE5CF),
  const Color(0xffC3E8C5),
  const Color(0xff97B7C5),

];
  

 void _saveBook() {
  if (_titleController.text.isEmpty ||
      _authorController.text.isEmpty ||
      _typeController.text.isEmpty ||
      _selectedImage == null ||
      _selectedColor == null) { 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields, upload a photo, and select a color"),
      ),
    );
    return;
  }
  final imagePath = _selectedImage!.path;
  final colorValue = _selectedColor!.value;
  final bookData ={
    'title': _titleController.text,
    'author':_authorController.text,
    'type': _typeController.text,
    'imagePath': imagePath,
    'color': colorValue,
  };
  StorageManager.saveBook(bookData);

  Navigator.pushReplacement(context,
   MaterialPageRoute(builder: (context) => const BookManager()));
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BookManager())),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "A new book, a new adventure!",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Appcolors.black),
              ),
              const SizedBox(height: 4),
              const Text(
                "Add your book details",
                style: TextStyle(fontSize: 14, color: Appcolors.black),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                labelText: "Book Title",
                labelStyle: TextStyle(color: Appcolors.black),
                border: UnderlineInputBorder(),
                focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Appcolors.black),
                )
                ),
              ),
              const SizedBox(height: 15),
              
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(
                labelText: "Author",
                labelStyle: TextStyle(color: Appcolors.black),
                border: UnderlineInputBorder(),
                focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Appcolors.black),
                ),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _typeController,
                decoration: const InputDecoration(
                labelText: "Book Type",
                labelStyle: TextStyle(color:Appcolors.black),
                border: UnderlineInputBorder(),
                focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Appcolors.black),
                ),  
                ),
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upload Photo Cover:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  UploadPhotoField(
                    onImagePicked: (file) {
                      _selectedImage = file;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Choose a Color:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _availableColors.map((color) {
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
                          border: isSelected ? Border.all(color: Colors.black, width: 1) : null,
                        ),
                          width: 40,
                          height: 40,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 30),

             SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Save Book",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPhotoField extends StatefulWidget {
  final void Function(File?) onImagePicked;
  const UploadPhotoField({super.key, required this.onImagePicked});

  @override
  State<UploadPhotoField> createState() => _UploadPhotoFieldState();
}

class _UploadPhotoFieldState extends State<UploadPhotoField> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

 Future<void> _pickImage() async {
  try {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImagePicked(_imageFile);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error picking image: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _imageFile == null
            ? const Center(child: Text("Tap to upload photo"))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_imageFile!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
