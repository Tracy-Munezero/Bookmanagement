import 'package:bookapp/add_Screen.dart';
import 'package:bookapp/edit_Profile_Screen.dart';
import 'package:bookapp/library_screen.dart';
import 'package:bookapp/login.dart';
import 'package:flutter/material.dart';

class BookManager extends StatefulWidget {
  const BookManager({super.key});

  @override
  State<BookManager> createState() => _BookManagerState();
}

class _BookManagerState extends State<BookManager> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [

    LibraryScreen(),
    Container(color: Colors.white,),
     Container(color: Colors.white,),
    const EditProfileScreen(),
    ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //    'Book Manager'
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   titleTextStyle: const TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black,
      //     fontFamily: 'poppins',
      //   ),
        
        
      // ),
      body: _pages[_selectedIndex],

     floatingActionButton: _selectedIndex == 0
        ? FloatingActionButton(
            backgroundColor: Colors.blue.shade200,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddScreen()),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          )
        : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,  size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined,  size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined,  size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined,  size: 30,),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        
        onTap: _onItemTapped,
      ),
      
      
    );
  }
}




