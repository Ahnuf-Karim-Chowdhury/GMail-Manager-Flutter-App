import 'package:flutter/material.dart';
import 'package:gmail_manager/components/button.dart';
import 'package:gmail_manager/components/textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Enter email to get password reset email",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  child: UITextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                ),
              ),

              UIButton(onTap: (){}, 
              text: "Reset Password",
              paddingWidth: 30,),
              //empty space
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
