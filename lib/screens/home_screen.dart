import 'package:expense_manager/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController _passwordTextController = TextEditingController();
  // TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              // Color.fromRGBO(157, 47, 243, 1.0),
              Color.fromRGBO(45, 68, 211, 1.0),
              Color.fromRGBO(43, 203, 203, 1.0),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: ElevatedButton(
            child: Text("Logout"),
            onPressed: (){
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>SignIn()));
              });
            },
          ),
        ),
      ),
    );
  }



}
