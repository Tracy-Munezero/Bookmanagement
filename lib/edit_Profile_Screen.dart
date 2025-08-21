import 'package:bookapp/login.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _username = TextEditingController(text: 'Mabuja');
  final _email = TextEditingController(text: 'Mabuja@gmail.com');

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: Colors.black.withOpacity(.5),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 16),
          const _Avatar(),
          const SizedBox(height: 36),

          const Text(
            'Username',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _username,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {},
              )
            ],
          ),
          divider,
          const SizedBox(height: 20),

          const Text(
            'Email',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black54 ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _email,
            enabled: false,
            decoration: const InputDecoration(border: InputBorder.none),
            style: TextStyle(color: Colors.black.withOpacity(.6)),
          ),
          divider,
          const SizedBox(height: 40),

          SizedBox(
            height: 56,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue.shade200),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    const size = 120;
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.blueGrey,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: const Icon(Icons.photo_camera_outlined, size: 20),
            ),
          )
        ],
      ),
    );
  }
}
