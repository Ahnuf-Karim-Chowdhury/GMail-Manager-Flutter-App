import 'package:flutter/material.dart';
import 'package:gmail_manager/components/textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              // logo
              Icon(Icons.lock, size: 100),

              //empty space
              SizedBox(height: 50),

              // Greeting
              Text(
                "Welcome Back",
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
              //empty space
              SizedBox(height: 25),

              //username
              UITextField(
                controller: usernameController,
                hintText: "UserName",
                obscureText: false,
              ),

              //empty space
              SizedBox(height: 25),

              // password
              UITextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
