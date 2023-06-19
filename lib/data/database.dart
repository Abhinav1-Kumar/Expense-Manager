import 'package:expense_manager/data/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../functions/graph.dart';
// import 'package:firebase_auth/firebase_auth.dart';




int total_expense=0;
int total_income=0;
List<String> price =[];

class DatabaseManager{
    void createUserData(String name,String email,String uid) async{
    final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');
    profileList.doc(uid).set({
      'name':name,
      'email':email,
    });
  }

  Future<String> get_uid() async{
    String _uid ="hello";
    _uid = await FirebaseAuth.instance.currentUser!.uid;
    return _uid;
}

  Future get_user() async {
    var userData = await FirebaseFirestore
        .instance
        .collection('profileInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return userData;
  }




}


