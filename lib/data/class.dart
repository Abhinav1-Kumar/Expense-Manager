import 'package:cloud_firestore/cloud_firestore.dart';

class trans{
  String? name;
  String? amount;
  Timestamp? time;
  String? image;
  bool? credit;
  trans(this.name,this.amount,this.time,this.credit,this.image);
}

class User{
  String? name;
  String? email;

  Map<String,dynamic> toJson()=>{
    'name': name,
    'email' :email,
  };
}
