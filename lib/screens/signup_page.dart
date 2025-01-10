import 'package:flutter/material.dart';
import '../apis/auth_api.dart';
import '../model/user_model.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onSignInPressed;

  const SignUpPage({Key? key, required this.onSignInPressed}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void onSignup(BuildContext context) async {
    final userCredential = await AuthAPI().googleSignin();
    if (userCredential != null) {
      final userData = UserModel(
          disorderName: '',
          email: userCredential.user?.email ?? '',
          emotion: '',
          patientAge: '18',
          patientGender: '',
          patientName: '',
          phoneNumber: '',
          sessionId: '',
          uid: userCredential.user?.uid ?? '');
      final authAPI = AuthAPI();
      final loggedUser = await authAPI.readCurrentUser();
      if (loggedUser == null) {
        await authAPI.createUser(userData);
      }
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google Sign-In failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30.0),
          OutlinedButton.icon(
            onPressed: () {
              onSignup(context);
            },
            icon: const Icon(Icons.drafts, color: Colors.red),
            label: const Text(
              'Sign up with Google    ',
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
                'Already have an account?',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: widget.onSignInPressed,
                child: const Text(
                  'Sign In',
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
