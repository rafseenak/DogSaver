// ignore_for_file: use_build_context_synchronously

import 'package:dog_catcher/main.dart';
import 'package:dog_catcher/screens/home_screen.dart';
import 'package:dog_catcher/screens/signup_screen.dart';
import 'package:dog_catcher/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void _loginError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('There is an error, Try Again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 199, 199),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 229, 229),
                    border: Border.all(
                      color: const Color.fromARGB(255, 230, 229, 229),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your Email address',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 229, 229),
                    border: Border.all(
                      color: const Color.fromARGB(255, 230, 229, 229),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an Account? Sign Up Here!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.lock),
                  label: const Text('LOGIN'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () async {
                    dynamic result = await _auth.loginEmail(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (result == null) {
                      _loginError(context);
                    } else {
                      final sharedPreference =
                          await SharedPreferences.getInstance();
                      await sharedPreference.setBool(SAVE_KEY_NAME, true);
                      await sharedPreference.setBool(ANONIMOUS_KEY, false);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (ctx) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      dynamic result = await _auth.loginAnonimous();
                      if (result == null) {
                        _loginError(context);
                      } else {
                        final sharedPreference =
                            await SharedPreferences.getInstance();
                        await sharedPreference.setBool(SAVE_KEY_NAME, true);
                        await sharedPreference.setBool(ANONIMOUS_KEY, true);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text(
                      "Continue With out Sign In",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                // const Text(
                //   'Or Continue With',
                //   style: TextStyle(
                //     color: Color.fromARGB(255, 0, 0, 0),
                //     fontSize: 13,
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(15.0),
                //       child: MouseRegion(
                //         cursor: SystemMouseCursors.click,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //             decoration: BoxDecoration(
                //               shape: BoxShape.rectangle,
                //               color: const Color.fromARGB(255, 230, 229, 229),
                //               border: Border.all(
                //                 color: const Color.fromARGB(255, 230, 229, 229),
                //                 width: 2.0,
                //               ),
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(10),
                //               ),
                //             ),
                //             child: const Image(
                //               image: AssetImage('assets/logos/google.png'),
                //               height: 40,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(15.0),
                //       child: MouseRegion(
                //         cursor: SystemMouseCursors.click,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //             decoration: BoxDecoration(
                //               shape: BoxShape.rectangle,
                //               color: const Color.fromARGB(255, 230, 229, 229),
                //               border: Border.all(
                //                 color: const Color.fromARGB(255, 230, 229, 229),
                //                 width: 2.0,
                //               ),
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(10),
                //               ),
                //             ),
                //             child: const Image(
                //               image: AssetImage('assets/logos/apple.png'),
                //               height: 40,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
