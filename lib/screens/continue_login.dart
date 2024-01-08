import 'login_screen.dart';
import 'package:flutter/material.dart';

class ContinueLogin extends StatelessWidget {
  const ContinueLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign Up to Continue.',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('SIGN UP'),
            )
          ],
        ),
      ),
    );
  }
}
