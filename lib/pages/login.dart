import 'package:flutter/material.dart';
import 'package:gmail_manager/components/button.dart';
import 'package:gmail_manager/components/textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //functions
  void signIn() {}

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
              SizedBox(height: 10),

              // password
              UITextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              //empty space
              SizedBox(height: 10),

              //forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Passsword?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              //empty space
              SizedBox(height: 25),

              //Sign In Button
              UIButton(onTap: signIn),

              //empty space
              SizedBox(height: 50),

              // OR divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25 ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1.5, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1.5, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  //google log in
                  SvgPicture.asset('lib/icons/google.svg', height: 72,),

                  //

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
