import 'package:flutter/material.dart';
import '../apis/auth_api.dart';

class SignInPage extends StatelessWidget {
  final VoidCallback onSignUpPressed;

  const SignInPage({Key? key, required this.onSignUpPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void onSignin(BuildContext context) async {
    final userCredential = await AuthAPI().googleSignin();
    if (userCredential != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'SIGN IN',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30.0),
          OutlinedButton.icon(
           onPressed: () {
              onSignin(context);
            },
            icon: const Icon(Icons.drafts, color: Colors.red),
            label: const Text(
              'Sign in with Google   ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              side: const BorderSide(color: Colors.black),
            ),
          ),        
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: onSignUpPressed,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
