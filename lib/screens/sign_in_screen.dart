import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/commonFunctions.dart';
import 'home_screen.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
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
          ], begin: Alignment.bottomCenter,end:Alignment.topCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 500,
                ),
                reusableTextField("Enter your email", Icons.account_circle,false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your password", Icons.lock,true, _passwordTextController),
                const SizedBox(
                  height: 15,
                ),
                signInSignUp(context, "Log In", () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                  });
                },),
                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
