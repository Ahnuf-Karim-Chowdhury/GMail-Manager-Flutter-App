import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/pages/forgot_password.dart';
import 'package:logger/logger.dart';
import 'package:gmail_manager/components/button.dart';
import 'package:gmail_manager/components/squareTile.dart';
import 'package:gmail_manager/components/textfield.dart';
import 'package:gmail_manager/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Initialize the logger
  final Logger logger = Logger();

  //functions
  void signIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      logger.i('User signed in successfully');

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
                    SizedBox(height: height * 0.05),

                    // Greeting
                    Text(
                      "Welcome Back",
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
                          hintText: "Email",
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

                    // forgot Password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //empty space
                    SizedBox(height: height * 0.03),

                    // Sign In Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                      child: UIButton(onTap: signIn, text: "Sign In"),
                    ),

                    //empty space
                    SizedBox(height: height * 0.05),

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
                    SizedBox(height: height * 0.03),

                    // Row for login options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // google log in
                        SquareTile(
                          imagePath: "lib/icons/google.svg",
                          onTap: () => Authservice().signInWithGoogle(),
                        ),

                        SizedBox(width: width * 0.05),

                        // github log in
                        SquareTile(
                          imagePath: "lib/icons/github.svg",
                          onTap: () => Authservice().signInWithGoogle(),
                        ),
                      ],
                    ),

                    //empty space
                    SizedBox(height: height * 0.03),

                    // Don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: width * 0.01),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Register",
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
