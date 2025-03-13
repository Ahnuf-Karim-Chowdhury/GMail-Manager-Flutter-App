import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final Logger logger = Logger();
  bool _isLoading = false;
  bool _showMessage = false;
  final TextEditingController _typingController = TextEditingController();
  String _fullMessage = "Please allow some time for the email to be delivered. Thank you for your patience.";
  int _currentCharIndex = 0;
  Timer? _timer;

  @override
  void dispose() {
    emailController.dispose();
    _typingController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future passwordResetLink() async {
    setState(() {
      _isLoading = true;
      _showMessage = false;
      _typingController.clear();
      _currentCharIndex = 0;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.9), // Adjust transparency here
            content: Text("Password Reset Link Sent! Check your Email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _showMessage = true;
                  });
                  _startTypingAnimation();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      logger.e('Error forgot password: $e');
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        default:
          errorMessage = e.message.toString();
          break;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade200.withOpacity(0.9), // Adjust transparency here
            content: Text(errorMessage),
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startTypingAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_currentCharIndex < _fullMessage.length) {
          _typingController.text += _fullMessage[_currentCharIndex];
          _currentCharIndex++;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
        title: Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.grey,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Enter email to get password reset email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.grey[700], // Before Clicking the hint text color
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // Before Clicking the border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400, // Before Clicking the border color
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: passwordResetLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Button color
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
              SizedBox(height: height * 0.02),
              if (_showMessage)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        controller: _typingController,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
