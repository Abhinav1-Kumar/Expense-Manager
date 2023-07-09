import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/data/database.dart';
import 'package:expense_manager/functions/graph.dart';
import 'package:expense_manager/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '';
import '../data/top.dart';
import '../main.dart';
import 'add_trans.dart';



List<SalesData> _dayI=[];
List<SalesData> _weekI=[];
List<SalesData> _monthI=[];
List<SalesData> _yearI=[];
List<SalesData> _dayE=[];
List<SalesData> _weekE=[];
List<SalesData> _monthE=[];
List<SalesData> _yearE=[];
List<SalesData> _chartData=[];

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  int type = 0;
  int temp=0;
  bool asc=true;
  String? selectedItem1;
  final List<String> _type=['Income','Expense'];
  List<String> mp =["Mon","Tues","Wed","Thurs","Fri","Sat","Sun"];
  @override
  void initState() {
    selectedItem1='Expense';
    super.initState();
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore
            .instance
            .collection('profileInfo')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('transactions').orderBy('amount',descending: true).snapshots(),
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
          chartInit(snapshot);
          // _chartData=getChartData(snapshot);
          return SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          'Analysis',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            box('Day',0),
                            box('Week',1),
                            box('Month',2),
                            box('Year',3),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 180,
                                height: 40,
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
                                      'Expense',
                                      style: TextStyle(fontSize: 18,),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        SizedBox(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: _sChart(),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem1=='Income'?'Top Earning':'Top Spending',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(asc==true){
                                      asc=false;
                                    }
                                    else{
                                      asc=true;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.swap_vert,size: 25,color:Colors.grey ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context,ind){
                          final index=asc==true?snapshot.data!.docs.length - ind - 1:ind;
                          // DateTime d= DateTime.parse(snapshot.data!.docs.elementAt(index).get('time').toDate().toString());
                          DateTime d=snapshot.data!.docs.elementAt(index).get('time').toDate();
                          DateTime t=DateTime.now();
                          if(selectedItem1=='Income'){
                            if(type==0){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==true && d.day==t.day && d.year==t.year && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==1){
                              var week=d.weekday;
                              d=d.subtract(Duration(days: week));
                              week = t.weekday;
                              t=t.subtract(Duration(days: week));
                              if(snapshot.data?.docs.elementAt(index).get('credit')==true && d.day==t.day && d.year==t.year && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==2){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==true && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==3){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==true && d.year==t.year){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                          }
                          else{
                            if(type==0){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==false && d.day==t.day && d.year==t.year && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==1){
                              var week=d.weekday;
                              d=d.subtract(Duration(days: week));
                              week = t.weekday;
                              t=t.subtract(Duration(days: week));
                              if(snapshot.data?.docs.elementAt(index).get('credit')==false && d.day==t.day && d.year==t.year && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==2){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==false && d.month==t.month){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                            if(type==3){
                              if(snapshot.data?.docs.elementAt(index).get('credit')==false && d.year==t.year){
                                return item(snapshot,index);
                              }
                              else{
                                return SizedBox(height: 0,);
                              }
                            }
                          }
                    },
                    childCount: snapshot.data?.docs.length,
                  ))
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
                          setState(() {
                            index_color = 2;
                          });
                        },
                        child: Icon(
                          Icons.home,
                          size: 30,
                          color: index_color == 2 ? const Color(0xff368983) : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index_color = 3;
                          });
                        },
                        child: Icon(
                          Icons.bar_chart_outlined,
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
        }
    );

  }

  ListTile item(AsyncSnapshot snapshot,int index){
    return ListTile(
      title: Text(
        snapshot.data?.docs.elementAt(index).get('name'),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text("${mp[snapshot.data!.docs.elementAt(index).get('time').toDate().weekday-1]} ${snapshot.data!.docs.elementAt(index).get('time').toDate().day} - ${snapshot.data!.docs.elementAt(index).get('time').toDate().month} -${snapshot.data!.docs.elementAt(index).get('time').toDate().year}",
      ),
      trailing: Text(
        "Rs "+snapshot.data!.docs.elementAt(index).get('amount').toString(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: snapshot.data!.docs.elementAt(index).get('credit')! ? Colors.green : Colors.red,
        ),
      ),
    );
  }


  Container _sChart(){
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<SalesData,String>>[
          LineSeries<SalesData,String>(
            color: Colors.blue,
            width: 3,
            dataSource:selectedItem1=='Income'?
                          type==0?_dayI:
                          type==1?_weekI:
                          type==2?_monthI:
                          _yearI:
                      type==0?_dayE:
                      type==1?_weekE:
                      type==2?_monthE:
                      _yearE,
            xValueMapper: (SalesData sales,_)=>type==0?sales.year.hour.toString()
                :type==1?mp[sales.year.weekday-1]
                :type==2?sales.year.day.toString()
                :sales.year.month.toString(),
            yValueMapper: (SalesData sales,_)=>sales.sales,
          )
        ],
      ),
    );
  }

  void chartInit(AsyncSnapshot snapshot){
    _dayI = [];
    _weekI = [];
    _monthI = [];
    _yearI = [];
    _dayE=[];
    _weekE=[];
    _monthE=[];
    _yearE=[];
    DateTime t = DateTime.now();
    _chartData=[];
    for(var i=0;i<31;i++){
      _monthI.add(SalesData(0, t.subtract(Duration(days:t.day-i))));
      _monthE.add(SalesData(0, t.subtract(Duration(days:t.day-i))));
    }
    for(var i=0;i<7;i++){
      _weekI.add(SalesData(0, t.subtract(Duration(days:t.weekday-i))));
      _weekE.add(SalesData(0, t.subtract(Duration(days:t.weekday-i))));
    }
    for(var i=0;i<24;i++){
      _dayI.add(SalesData(0, t.subtract(Duration(hours:t.hour-i))));
      _dayE.add(SalesData(0, t.subtract(Duration(hours:t.hour-i))));
    }
    for(var i=0;i<12;i++){
      _yearI.add(SalesData(0, DateTime(t.year,i+1,4)));
      _yearE.add(SalesData(0, DateTime(t.year,i+1,4)));
    }

    _dayI.sort((a, b) => a.year.hour.compareTo(b.year.hour));
    _weekI.sort((a, b) => a.year.weekday.compareTo(b.year.weekday));
    _monthI.sort((a, b) => a.year.day.compareTo(b.year.day));
    _yearI.sort((a, b) => a.year.month.compareTo(b.year.month));

    _dayE.sort((a, b) => a.year.hour.compareTo(b.year.hour));
    _weekE.sort((a, b) => a.year.weekday.compareTo(b.year.weekday));
    _monthE.sort((a, b) => a.year.day.compareTo(b.year.day));
    _yearE.sort((a, b) => a.year.month.compareTo(b.year.month));

    for (var i = 0; i < snapshot.data.docs.length; i++) {
      DateTime d = snapshot.data.docs.elementAt(i).get('time').toDate();
      int a =snapshot.data.docs.elementAt(i).get('amount');
      if(snapshot.data.docs.elementAt(i).get('credit')){
        if (d.year == t.year) {
          _yearI[d.month-1].sales =_yearI[d.month-1].sales + a;
          _chartData.add(SalesData(a,d));
        }
        if (d.month == t.month && d.year == t.year) {
          _monthI[d.day].sales =_monthI[d.day].sales + a;
        }
        var week=d.weekday;
        DateTime temp1=d.subtract(Duration(days: week));
        week = t.weekday;
        DateTime temp2=t.subtract(Duration(days: week));
        if (temp1.day==temp2.day && temp1.month==temp2.month && temp1.year==temp2.year) {
          _weekI[d.weekday-1].sales=_weekI[d.weekday-1].sales + a;
        }
        if (d.day == t.day && d.month == t.month && d.year == t.year) {
          _dayI[d.hour].sales=_dayI[d.hour].sales + a;
        }
      }
      else{
        if (d.year == t.year) {
          _yearE[d.month-1].sales =_yearE[d.month-1].sales + a;
          _chartData.add(SalesData(a,d));
        }
        if (d.month == t.month && d.year == t.year) {
          _monthE[d.day].sales =_monthE[d.day].sales + a;
        }
        var week=d.weekday;
        DateTime temp1=d.subtract(Duration(days: week));
        week = t.weekday;
        DateTime temp2=t.subtract(Duration(days: week));
        if (temp1.day==temp2.day && temp1.month==temp2.month && temp1.year==temp2.year) {
          _weekE[d.weekday-1].sales=_weekE[d.weekday-1].sales + a;
        }
        if (d.day == t.day && d.month == t.month && d.year == t.year) {
          _dayE[d.hour].sales=_dayE[d.hour].sales + a;
        }
      }

    }
    _dayI.sort((a, b) => a.year.hour.compareTo(b.year.hour));
    _weekI.sort((a, b) => a.year.weekday.compareTo(b.year.weekday));
    _monthI.sort((a, b) => a.year.day.compareTo(b.year.day));
    _yearI.sort((a, b) => a.year.month.compareTo(b.year.month));

    _dayE.sort((a, b) => a.year.hour.compareTo(b.year.hour));
    _weekE.sort((a, b) => a.year.weekday.compareTo(b.year.weekday));
    _monthE.sort((a, b) => a.year.day.compareTo(b.year.day));
    _yearE.sort((a, b) => a.year.month.compareTo(b.year.month));
  }



  GestureDetector box(String t,int k){
    return GestureDetector(
      onTap: (){
        setState(() {
          type=k;
        });
      },
      child: Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: type==k?Colors.blue:Colors.white,
          ),
          child: Center(
            child: Text(
              t,
              style: TextStyle(
                color: type==k?Colors.white:Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ),
    );
  }
}
