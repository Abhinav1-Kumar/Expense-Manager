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
      appBar: AppBar(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
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
                            Color.fromRGBO(157, 47, 243, 1.0),
                            Color.fromRGBO(45, 68, 211, 1.0),
                            Color.fromRGBO(43, 203, 203, 1.0),
                          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 35,
                              left: 340,
                              child:Container(
                                height: 40,
                                width: 40,
                                color:Colors.blue ,
                                child: Icon(
                                  Icons.notification_add_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:35,left:10 ),
                              child: Column(
                                children: [
                                  Text(
                                    'Good afternoon',
                                    style: TextStyle(
                                      fontWeight:FontWeight.w500,
                                      fontSize: 16,
                                      color:Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Abhinav Kumar',
                                    style: TextStyle(
                                      fontWeight:FontWeight.w500,
                                      fontSize: 20,
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
                                  'Rs 500',
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
                                      backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
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
                                      backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
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
                                  'Rs 1000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Rs 500',
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
          ),
          SliverToBoxAdapter(
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index){
                return Container(
                  height: 60,
                  child: ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text(
                      'Transaction',
                        style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Date'),
                    trailing: Text(
                      'Rs100',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }



}
