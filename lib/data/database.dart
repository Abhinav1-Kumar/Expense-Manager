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


    void transList(String uid,String name,int amount,bool credit,DateTime date) async{
      CollectionReference ref=FirebaseFirestore.instance.collection('profileInfo');
      ref.doc(uid).collection('transactions').add({
        'name':name,
        'amount':amount,
        'credit':credit,
        'time':date,
        'image':'up.png',
      });
    }

    Future get_trans() async{
      var t=await FirebaseFirestore.instance.collection('profileInfo').doc(FirebaseAuth.instance.currentUser!.uid).collection('transactions').get();
      return t;
    }
    Future<void> initialise() async {
      total_income = 0;
      total_expense = 0;
      var t = await FirebaseFirestore.instance.collection('profileInfo').doc(
          FirebaseAuth.instance.currentUser!.uid)
          .collection('transactions')
          .orderBy('time')
          .get();
      for (var i = 0; i < t.docs.length; i++) {
        if (t.docs.elementAt(i).get('credit')) {
          total_income =
              total_income + int.parse(t.docs.elementAt(i).get('amount').toString());
        }
        else {
          total_expense =
              total_expense + int.parse(t.docs.elementAt(i).get('amount').toString());
        }
      }
    }

    Future<QuerySnapshot<Map<String, dynamic>>> getDb() async {
      var db =  await FirebaseFirestore.instance
          .collection('profileInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('transactions')
          .orderBy('time',descending: true)
          .get();
      return db;
    }
}

class SalesData{
  SalesData(this.sales,this.year);
  final DateTime year;
  int sales;
}

