import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/services/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _auth = Authservice();

  late Timer timer;
  late Timer countdownTimer;
  int _countdown = 60;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerificationLink();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (countdownTimer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        countdownTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    countdownTimer.cancel();
    super.dispose();
  }

  void _resendVerificationEmail() async {
    setState(() {
      _isResending = true;
      _countdown = 60;
    });

    await _auth.sendEmailVerificationLink(); // Use your Authservice method to send the email

    setState(() {
      _isResending = false;
    });

    _showConfirmationDialog();
    startCountdown();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Resent'),
          content: Text('Verification email has been resent successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Your Email')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'A verification email has been sent to your email address. Please check your inbox and follow the instructions to verify your email.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _countdown > 0 ? null : _resendVerificationEmail,
                child: _isResending
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    : Text(_countdown > 0
                        ? 'Resend Verification Email in $_countdown seconds'
                        : 'Resend Verification Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
