import 'package:flutter/material.dart';

class LibraryScreen
 extends StatelessWidget {
  const LibraryScreen
  ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
           appBar: AppBar(
        title: Text(
         'Book Manager'
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'poppins',
        ),
           ),
      body: Container(color: Colors.white,
      child:GridView.builder(
        itemCount: 20,
        padding: EdgeInsets.all(16),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 14,
          crossAxisSpacing: 10,
       crossAxisCount: 2, // number of columns
        ), itemBuilder: (context,index)=>Container(decoration: BoxDecoration(
          color: Color(0xffEFE9E9),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),padding: EdgeInsets.all(16),child: Text(""),),),),
    );
  }
}