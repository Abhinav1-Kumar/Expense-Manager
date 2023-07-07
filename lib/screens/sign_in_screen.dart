import 'dart:core';

import 'package:expense_manager/screens/analysis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/database.dart';
import '../functions/commonFunctions.dart';
import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String eError = "";
  String pError = "";
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  void initState() {
    eError = "";
    pError = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(47, 80, 243, 1.0),
            Color.fromRGBO(45, 167, 211, 1.0),
            Color.fromRGBO(43, 203, 203, 1.0),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 500,
                ),
                // CustomTextField(controller: _emailController, labelText: "Email", hintText: "", inputType: TextInputType.emailAddress, errorText: '_emailError',),
                reusableTextField("Enter your email", Icons.account_circle,
                    false, _emailTextController, eError),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your password", Icons.lock, true,
                    _passwordTextController, pError),
                const SizedBox(
                  height: 15,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () {
                      signInUsingEmail();
                    },
                    child: Text(
                      'Log In',
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black26;
                          }
                          return Colors.white;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                  ),
                ),

                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUsingEmail() async {
    if (_emailTextController.text.isEmpty) {
      setState(() {
        eError = "Email required.";
      });
      return;
    } else {
      setState(() {
        eError = "";
      });
    }
    if (_passwordTextController.text.isEmpty) {
      setState(() {
        pError = "Password required.";
      });
      return;
    }else {
      setState(() {
        pError = "";
      });
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email' ||
          error.code == 'user-disabled' ||
          error.code == 'user-not-found') {
        setState(() {
          eError = 'Invalid Email';
        });
      }
      if (error.code == 'wrong-password') {
        setState(() {
          pError = 'Incorrect Password';
        });
      }
    }
  }
}
