import 'package:expense_manager/data/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTrans extends StatefulWidget {
  const AddTrans({Key? key}) : super(key: key);

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  DateTime date = DateTime.now();
  String? _uid;
  final TextEditingController explain = TextEditingController();
  final TextEditingController amount = TextEditingController();
  String? selectedItem;
  String? selectedItem1;
  final List<String> _item =[
    "Food","Transfer","Transportation","Education"
  ];
  final List<String> _type=['Income','Expense'];
  @override
  void initState() {
    super.initState();
    _uid = 'Hello';
    _uid = FirebaseAuth.instance.currentUser!.uid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(47, 80, 243, 1.0),
                      Color.fromRGBO(45, 167, 211, 1.0),
                      Color.fromRGBO(43, 203, 203, 1.0),
                    ], begin: Alignment.bottomCenter,end:Alignment.topCenter),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back, color: Colors.white),
                            ),
                            Text(
                              'Adding',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.attach_file_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 120,
              left: 20,
              child: Container(
                height: 550,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        child: DropdownButton<String>(
                          value: selectedItem,
                          items:_item
                            .map((e)=>DropdownMenuItem(
                              child: Container(
                                child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        child: Icon(Icons.abc),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        e,
                                        style: TextStyle(fontSize: 18,),
                                      )
                                    ],
                                ),
                              ),
                            value: e,
                            )).toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              _item.map((e) => Row(
                                children: [
                                  Container(
                                    width: 42,
                                    child: Icon(Icons.abc),
                                  ),
                                  SizedBox(width: 5),
                                  Text(e)
                                ],
                              )).toList(),
                          hint: Text(
                            "Name",
                            style: TextStyle(color: Colors.grey),
                          ),
                          underline: Container(),
                          isExpanded: true,
                          onChanged: ((value){
                            setState(() {
                              selectedItem=value!;
                            });
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        // focusNode: ex,
                        controller: explain,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          labelText: 'explain',
                          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Color(0xff368983))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: amount,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          labelText: 'amount',
                          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Color(0xff368983))),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        child: DropdownButton<String>(
                          value: selectedItem1,
                          items:_type
                              .map((e)=>DropdownMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child: Icon(Icons.abc),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    e,
                                    style: TextStyle(fontSize: 18,),
                                  )
                                ],
                              ),
                            ),
                            value: e,
                          )).toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              _type.map((e) => Row(
                                children: [
                                  Container(
                                    width: 42,
                                    child: Icon(Icons.abc),
                                  ),
                                  SizedBox(width: 5),
                                  Text(e)
                                ],
                              )).toList(),
                          hint: Text(
                            'Type',
                            style: TextStyle(color: Colors.grey),
                          ),

                          underline: Container(),
                          isExpanded: true,
                          onChanged: ((value){
                            setState(() {
                              selectedItem1=value!;
                            });
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
                      width: 300,
                      child: TextButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100));
                          if (newDate == Null) return;
                          setState(() {
                            date = newDate!;
                          });
                        },
                        child: Text(
                          'Date : ${date.day} / ${date.month} / ${date.year}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        if(selectedItem1=='Income'){
                          total_income = total_income+int.parse(amount.text);
                        }
                        else{
                          total_expense=total_expense+int.parse(amount.text);
                        }
                        DatabaseManager().transList(_uid!, selectedItem!, int.parse(amount.text), selectedItem1=='Income', date);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        width: 120,
                        height: 50,
                        child: Text(
                          // 'Rs $total_expense',
                          'Save',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
