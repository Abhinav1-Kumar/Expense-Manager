class trans{
  String? name;
  String? amount;
  String? time;
  String? image;
  bool? credit;
}

class User{
  String? name;
  String? email;

  Map<String,dynamic> toJson()=>{
    'name': name,
    'email' :email,
  };

  // static User fromJson(Map<String,dynamic> json)=>User(
  //   name:json['name'],
  //   email:json['email'],
  // )
}
