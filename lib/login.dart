// ignore: unused_import
import 'dart:ffi';

import 'package:bookapp/local_storage.dart';
// ignore: unused_import
import 'package:bookapp/main.dart';
import 'package:bookapp/signup.dart';
import 'package:flutter/material.dart';

import 'home.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Login to your account",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              CustomTextField(controller: _emailController,labelText: "Email",hintText: "Enter your email",prefixIcon: Icon(Icons.person_outline),),
              const SizedBox(height: 20),

              CustomTextField(controller: _passwordController, labelText: "Password", hintText: "Enter your password",obscureText: true,prefixIcon: Icon(Icons.lock_outline),),
              const SizedBox(height: 10),             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.black,
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {}, 
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(color: Color.fromARGB(255, 125, 192, 247)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill in all fields")),
                    );
                    return;
                  }

                  final users = StorageManager.getUsers();
                  final storedUser = users.firstWhere(
                    (user) => user['email'] == _emailController.text && user['password'] == _passwordController.text,
                    orElse: () => null,
                  );

                  if (storedUser != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login successful")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const BookManager()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid email or password")),
                    );
                  }
                },

                 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                    
                  ),
                ),
              ),

              const SizedBox(height: 30),              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    }, 
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Color.fromARGB(255, 125, 192, 247)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
   CustomTextField({required this.controller ,required this.labelText,required this.hintText, this.obscureText=false,this.prefixIcon });
 final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  
  final TextEditingController controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
     return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText:labelText,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: prefixIcon,
        hintText: hintText,
        border: const UnderlineInputBorder(),
        
      ),
    );
  }
}

