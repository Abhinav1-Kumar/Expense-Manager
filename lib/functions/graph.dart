import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <SplineSeries<SalesData,String>>[
            SplineSeries<SalesData,String>(
                color: Colors.blue,
                width: 3,
                dataSource:<SalesData>[
                  SalesData(100, 'Mon'),
                  SalesData(400, 'Tue'),
                  SalesData(200, 'Wed'),
                  SalesData(300, 'Sun'),
                ],
              xValueMapper: (SalesData sales,_)=>sales.year,
              yValueMapper: (SalesData sales,_)=>sales.sales,
            )
          ],
      ),
    );
  }
}




class SalesData{
  SalesData(this.sales,this.year);
  final String year;
  final int sales;
}