import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:practice_quiz/utils/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username = '';
  String password = '';
  String confirmPassword = '';
  bool isRegisterSuccess = false;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500, minHeight: 750),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 52,
                            color: mainBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _email(),
                  _username(),
                  _password(),
                  _confirmPassword(),
                  _signupButton(),
                  _loginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: lighText),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_outline_rounded),
          hintText: 'Username',
          hintStyle: TextStyle(
            color: lighText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (value) {
          username = value;
        },
      ),
    );
  }

  Widget _password() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: lighText),
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_outline_rounded),
          hintText: 'Password',
          hintStyle: TextStyle(
            color: lighText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (value) {
          password = value;
        },
      ),
    );
  }

  Widget _confirmPassword() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: lighText),
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_outline_rounded),
          hintText: 'Re-Input Password',
          hintStyle: TextStyle(
            color: lighText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (value) {
          confirmPassword = value;
        },
      ),
    );
  }

  Widget _signupButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.75,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: ElevatedButton(
          onPressed: () {
            String text = '';
            if (!isUsernameValid(username)) {
              text =
                  'Username should be 4-20 alphanumerical characters, dots (.), or underscores (_).';
              isRegisterSuccess = false;
            } else if (!validatePassword(password)) {
              text =
                  'Password should be at least 8 character consisted of uppercase, lowercase, number, and symbol.';
              isRegisterSuccess = false;
            } else if (password == confirmPassword) {
              if (!box.hasData(username.toLowerCase())) {
                String hashedPassword = _hashPassword(password);
                box.write(username.toLowerCase(), [hashedPassword, username]);
                text = 'Sign up success!';
                isRegisterSuccess = true;
              } else {
                text = 'Username is taken, please try another one!';
                isRegisterSuccess = false;
              }
            } else {
              text = 'Password is not identical!';
              isRegisterSuccess = false;
            }
            SnackBar snackbar = SnackBar(content: Text(text));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            if (isRegisterSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(20),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            )),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: mainBlue,
            ),
          )
        ],
      ),
    );
  }

  String _hashPassword(String password) {
    List<int> bytes = utf8.encode(password);
    Digest sha256Result = sha256.convert(bytes);
    return sha256Result.toString();
  }

  bool validatePassword(String password) {
    // Minimum length of 8 characters
    if (password.length < 8) {
      return false;
    }
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return false;
    }
    // Check for at least one special character
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      return false;
    }
    // All checks passed, the password is strong
    return true;
  }

  bool isUsernameValid(String username) {
    // Minimum length of 4 and maximum of 20 characters
    if (username.length < 4 || username.length > 20) {
      return false;
    }
    // Check if the username contains only alphanumerical characters, dots, or underscores
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(username)) {
      return false;
    }
    // Check if the username doesn't consist solely of underscores or dots
    if (RegExp(r'^[_]+$').hasMatch(username) ||
        RegExp(r'^[.]+$').hasMatch(username)) {
      return false;
    }
    // All checks passed, the username is valid
    return true;
  }
}