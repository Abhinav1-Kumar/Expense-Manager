// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import '../data/database.dart';
//
// class Graph extends StatefulWidget {
//   const Graph({Key? key}) : super(key: key);
//
//   @override
//   State<Graph> createState() => _GraphState();
// }
//
//
// List<DateTime> day=[];
// List<DateTime> week=[];
// List<DateTime> month=[];
// List<DateTime> year=[];
// List<SalesData> _chartData=[];
//
//
// class _GraphState extends State<Graph> {
//   DateTime abc=DateTime.now();
//
//   var db;
//   @override
//   void initState() {
//     db = DatabaseManager().getDb();
//     _chartData=getChartData();
//     // chartInit();
//     // chartData.add(SalesData(100, DateTime.now()));
//     // chartData.add(SalesData(200, DateTime.now().add(Duration(days: 1))));
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 300,
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           series: <SplineSeries<SalesData,String>>[
//             SplineSeries<SalesData,String>(
//               color: Colors.blue,
//                 width: 3,
//                 dataSource:_chartData,
//               xValueMapper: (SalesData sales,_)=>sales.year.day.toString(),
//               yValueMapper: (SalesData sales,_)=>sales.sales,
//             )
//           ],
//       ),
//     );
//   }
//   // Future<void> chartInit() async {
//   //   day = [];
//   //   week = [];
//   //   month = [];
//   //   year = [];
//   //   var db = await FirebaseFirestore.instance
//   //       .collection('profileInfo')
//   //       .doc(FirebaseAuth.instance.currentUser!.uid)
//   //       .collection('transactions')
//   //       .orderBy('time',descending: true)
//   //       .get();
//   //   DateTime t = DateTime.now();
//   //   for (var i = 0; i < db.docs.length; i++) {
//   //     // DateTime d=DateTime.parse(db.docs.elementAt(i).get('time').toDate().toString());
//   //     DateTime d = db.docs.elementAt(i).get('time').toDate();
//   //     if (d.year == t.year) {
//   //       year.add(d);
//   //     }
//   //     if (d.month == t.month && d.year == t.year) {
//   //       month.add(d);
//   //     }
//   //     if (d.subtract(Duration(days: d.weekday)) ==
//   //         t.subtract(Duration(days: t.weekday))) {
//   //       week.add(d);
//   //     }
//   //     if (d.day == t.day && d.month == t.month && d.year == t.year) {
//   //       day.add(d);
//   //     }
//   //     // chartData.add(SalesData(100*i, d.add(Duration(days: i))));
//   //   }
//   // }
//
//   List<SalesData> getChartData()  {
//
//     final List<SalesData> chartData=[];
//     for(int i=0;i<5;i++){
//       chartData.add(SalesData(200, DateTime.now().add(Duration(days: i))));
//     }
//     return chartData;
//   }
//
//
//
// }
//
//
//
//
//
//
// class SalesData{
//   SalesData(this.sales,this.year);
//   final DateTime year;
//   final int sales;
// }