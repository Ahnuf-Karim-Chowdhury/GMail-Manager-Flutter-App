import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:gmail_manager/components/button.dart';
import 'package:gmail_manager/components/squareTile.dart';
import 'package:gmail_manager/components/textfield.dart';
import 'package:gmail_manager/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
   const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Initialize the logger
  final Logger logger = Logger();

  void signUp() async {
    // Functions for showing error messages

    void showErrorMessage(String msg) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(msg, style: TextStyle(color: Colors.white)),
            ),
          );
        },
      );
    }

    // loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        logger.i('User Created successfully');

        // Redirect to '/verify-email' after successful registration
        if (mounted) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/verify-email');
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
        }
        showErrorMessage("Passwords Don't Match!");
      }

      // pop loading screen
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // pop loading screen
      if (mounted) {
        Navigator.pop(context);
      }

      showErrorMessage(e.code);

      logger.e('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    // logo
                    Icon(Icons.lock, size: width * 0.2),

                    //empty space
                    SizedBox(height: height * 0.01),

                    // Greeting
                    Text(
                      "Let's Get Started",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: width * 0.06,
                      ),
                    ),
                    //empty space
                    SizedBox(height: height * 0.03),

                    // username
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Container(
                        width: width * 0.85,
                        child: UITextField(
                          controller: emailController,
                          hintText: "UserName",
                          obscureText: false,
                        ),
                      ),
                    ),

                    //empty space
                    SizedBox(height: height * 0.02),

                    // password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Container(
                        width: width * 0.85,
                        child: UITextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                        ),
                      ),
                    ),

                    //empty space
                    SizedBox(height: height * 0.02),

                    // confirm password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Container(
                        width: width * 0.85,
                        child: UITextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          obscureText: true,
                        ),
                      ),
                    ),

                    //empty space
                    SizedBox(height: height * 0.04),

                    // Sign In Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                      child: UIButton(onTap: signUp, text: "Sign UP"),
                    ),

                    //empty space
                    SizedBox(height: height * 0.02),

                    // OR divider
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: Text(
                              "or",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //empty space
                    SizedBox(height: height * 0.02),

                    // Row for login options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // google log in
                        SquareTile(
                          imagePath: "lib/icons/google.svg",
                          onTap: () => Authservice().signInWithGoogle(context),
                        ),

                        SizedBox(width: width * 0.05),

                        // github log in
                        SquareTile(
                          imagePath: "lib/icons/github.svg",
                          onTap: () => Authservice().signInWithGoogle(context),
                        ),
                      ],
                    ),

                    //empty space
                    SizedBox(height: height * 0.03),

                    // Don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(width: width * 0.01),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
