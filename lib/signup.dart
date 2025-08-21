import 'package:bookapp/local_storage.dart';
import 'package:bookapp/login.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                "Sign Up",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Create your account",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),
             
             CustomTextField(controller: _nameController, labelText: "Name", hintText: "Please enter your name"),
              const SizedBox(height: 20),
            CustomTextField(controller: _emailController, labelText: "Email", hintText: "Please enter your email address"),
              const SizedBox(height: 20),
            CustomTextField(controller: _passwordController, labelText: "Password", hintText: "Please enter your password", obscureText: true,),
              const SizedBox(height: 20),
            CustomTextField(controller: _confirmPasswordController, labelText: "Confirm password", hintText: "Retype your password", obscureText: true,),
              const SizedBox(height: 30),

              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if(_emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty || _nameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill in all fields")),
                    );
                    return;
                  }
                  if(_passwordController.text != _confirmPasswordController.text){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }
                  if(!_emailController.text.contains('@') || !_emailController.text.contains('.')){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid email address")),
                    );
                    return;
                  }
                  //final storage= StorageManager();
                  final isRegistered = StorageManager.saveUser({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,
                  });
                  
                  if(isRegistered){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration Successful!"))
                    );
                    Navigator.pop(context); 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration Failed!"))
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
                    "Signup",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); 
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.blue.shade300),
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
