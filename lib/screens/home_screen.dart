
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/screens/analysis.dart';
import 'package:expense_manager/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/class.dart';
import '../data/database.dart';

import 'package:intl/intl.dart';

import '../main.dart';
import 'add_trans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int ans=0;
  late Timer timer;
  // List<trans> d=[];
  List<String> mp =["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  @override
  String? Name;
  String? _uid;
  QuerySnapshot? t;
  void initState() {
    super.initState();
    Name = 'User';
    DatabaseManager().get_user().then((value){
      setState((){
        Name=value['name'];
      });
    });
    DatabaseManager().get_uid().then((value){
      setState(() {
        _uid = value;
      });
    });
    DatabaseManager().get_trans().then((value){
      t=value;
    });
    DatabaseManager().initialise();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore
            .instance
            .collection('profileInfo')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('transactions').orderBy('time',descending: true).snapshots(),
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot
            )
        {
          if(snapshot.hasError){return Text('Something went wrong');}
          if(snapshot.connectionState==ConnectionState.waiting){
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white
            );
          }
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  head(snapshot),
                  mid(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context,index){
                        return Container(
                          height: 60,
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              snapshot.data!.docs.elementAt(index).get('name'),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("${mp[snapshot.data!.docs.elementAt(index).get('time').toDate().weekday-1]} ${snapshot.data!.docs.elementAt(index).get('time').toDate().day} - ${snapshot.data!.docs.elementAt(index).get('time').toDate().month} -${snapshot.data!.docs.elementAt(index).get('time').toDate().year}",
                            ),
                            trailing: Text(
                              "Rs "+snapshot.data!.docs.elementAt(index).get('amount').toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: snapshot.data!.docs.elementAt(index).get('credit')! ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount:snapshot.data?.docs.length,
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddTrans()));
                },
                child: Icon(Icons.add),
                backgroundColor: Color(0xff368983),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index_color = 0;
                          });
                        },
                        child: Icon(
                          Icons.home,
                          size: 30,
                          color: index_color == 0 ? const Color(0xff368983) : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Analysis()));
                          setState(() {
                            index_color = 1;
                          });
                        },
                        child: Icon(
                          Icons.bar_chart_outlined,
                          size: 30,
                          color: index_color == 1 ? const Color(0xff368983) : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index_color = 2;
                          });
                        },
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 30,
                          color: index_color == 2 ? const Color(0xff368983) : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Analysis()));
                          setState(() {
                            index_color = 3;
                          });
                        },
                        child: Icon(
                          Icons.person_outlined,
                          size: 30,
                          color: index_color == 3 ? const Color(0xff368983) : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }


  SliverToBoxAdapter head(AsyncSnapshot snapshot){
    return SliverToBoxAdapter(
      child: Container(
        height: 350,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(47, 80, 243, 1.0),
                      Color.fromRGBO(45, 167, 211, 1.0),
                      Color.fromRGBO(43, 203, 203, 1.0),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:35,left:10 ),
                        child: Column(
                          children: [
                            Text(
                              'Good afternoon',
                              style: TextStyle(
                                fontWeight:FontWeight.w500,
                                fontSize: 20,
                                color:Colors.white,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              Name!,
                              style: TextStyle(
                                fontWeight:FontWeight.w500,
                                fontSize: 24,
                                color:Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 140,
              left: 35,
              child: Container(
                height: 170,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              fontWeight:FontWeight.w500,
                              fontSize: 16,
                              color:Colors.white,
                            ),
                          ),
                          Icon(Icons.more_horiz,color: Colors.white,)
                        ],
                      ),
                    ),
                    // SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            getprice(),
                            style: TextStyle(
                              fontWeight:FontWeight.w500,
                              fontSize: 20,
                              color:Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
                                // backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.green,
                                  size: 19,
                                ),
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Income',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
                                // backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.red,
                                  size: 19,
                                ),
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Expenses',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs $total_income',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Rs $total_expense',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter mid(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions History',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.black,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }


  String getprice(){
    ans = total_income - total_expense;
    return 'Rs $ans';
  }
}



