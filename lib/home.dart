import 'package:bookapp/add_Screen.dart';
import 'package:bookapp/colors.dart';
import 'package:bookapp/edit_Profile_Screen.dart';
import 'package:bookapp/library_screen.dart';
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

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Appcolors.black,
          unselectedItemColor: Appcolors.darkBlack,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? const Icon(Icons.home, size: 30)
                  : const Icon(Icons.home_outlined, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? const Icon(Icons.search, size: 30)
                  : const Icon(Icons.search_outlined, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const Icon(Icons.folder, size: 30)
                  : const Icon(Icons.folder_outlined, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? const Icon(Icons.person, size: 30)
                  : const Icon(Icons.person_outline, size: 30),
              label: '',
            ),
          ],
        ),
      ),
    );
      
    
  }
}




