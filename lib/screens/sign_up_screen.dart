import 'package:expense_manager/data/database.dart';
import 'package:expense_manager/screens/home_screen.dart';
import 'package:expense_manager/screens/sign_in_screen.dart';
// import 'package:expense_manager/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/commonFunctions.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  String eError="";
  String pError="";
  String uError="";
  // late DatabaseManager db;
  // initialise(){
  //   db=DatabaseManager();
  //   db.initialise();
  // }


  @override
  void initState() {
    eError="";
    pError="";
    uError="";
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(47, 80, 243, 1.0),
                Color.fromRGBO(45, 167, 211, 1.0),
                Color.fromRGBO(43, 203, 203, 1.0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController,uError),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController,eError),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController,pError),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        onPressed: () {
                          signUpUsingEmail();
                        },
                        child: Text(
                          'Sign Up',
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
                  ],
                ),
              ))),
    );
  }

  Future<void> signUpUsingEmail() async {
    if (_userNameTextController.text.isEmpty) {
      setState(() {
        uError = "UserName required.";
      });
      return;
    } else {
      setState(() {
        uError = "";
      });
    }
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
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text)
          .then((value) {
        DatabaseManager().createUserData(_userNameTextController.text, _emailTextController.text, FirebaseAuth.instance.currentUser!.uid);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignIn()));
      });
      // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == 'email-already-in-use' ) {
        setState(() {
          eError = 'Email already in use';
        });
      }
      if (error.code == 'invalid-email' ) {
        setState(() {
          eError = 'Invalid Email Id';
        });
      }
      if (error.code == 'weak-password') {
        setState(() {
          pError = 'Weak Password';
        });
      }
    }
  }


}
