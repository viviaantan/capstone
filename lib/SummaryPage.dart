import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp (const SummaryPage());
}

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPage();
}


class _SummaryPage extends State<SummaryPage> with RestorationMixin {
String _displayText = 'Results go here';
final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');

@override
  void initState() {
    super.initState();
     _activateListeners();
  }

void _activateListeners() async{
  _database.child("omargrant/Glucose").onValue.listen((event) {
    final String glucose = event.snapshot.value.toString();
    setState(() {
      _displayText = '$glucose mg/dL';
    });
   });
  }

  RestorableInt currentSegment = RestorableInt(0);
  int _selectedIndex = 0;
  @override
  String get restorationId => 'cupertino_segmented_control';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(currentSegment, 'current_segment');
  }

  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment.value = newValue!;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    DailyGraph(),

    WeeklyGraph(),

    MonthlyGraph()

    ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    const segmentedControlMaxWidth = 500.0;
    
    final children = <int,Widget>{
      0: Text("Daily"),
      1: Text("Weekly"),
      2: Text("Monthly"),
    };
  
    return CupertinoPageScaffold(
      
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: 
        Text(
          'SUMMARY',
          style: TextStyle(fontSize: 20)
        )),
      
          child: DefaultTextStyle(
        style: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .copyWith(fontSize: 13),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 5),
              SizedBox(
                width: segmentedControlMaxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoSlidingSegmentedControl<int>(
                    children: children,
                    onValueChanged: onValueChanged,
                    groupValue: currentSegment.value,
                  ),
                ),
              ),
            Column(children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 300,
                alignment: Alignment.center,
                child: _widgetOptions.elementAt(currentSegment.value)),
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child:Row(
                  children: [
                  Text("Recent Measurements",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ])),
                Container(
                  color: Color.fromARGB(255, 239, 230, 230),
                  padding: const EdgeInsets.all(20),
                  height:100,
                  width: double.infinity,
                  child:Column(
                  children: [
                    Row(
                      children:[
                    Text(_displayText,
                    style: TextStyle(fontSize:18, fontWeight:FontWeight.bold))
                  ])
            ]))
                 
                 ])
                  ])
                )),
                
                )
              
              
          ;
  }
}

class DailyGraph extends StatelessWidget{
  const DailyGraph({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
           primaryXAxis: CategoryAxis(),
            series: <LineSeries<DailyData, String>>[
              LineSeries<DailyData, String>(
                // Bind data source
                dataSource:  <DailyData>[
                  DailyData('8:00', 35),
                  DailyData('9:00', 28),
                  DailyData('10:00', 34),
                  DailyData('11:00', 32),
                  DailyData('12:00', 40),
                  DailyData('13:00', 44),
                  DailyData('14:00', 42)
                ],
                xValueMapper: (DailyData bloodLvl, _) => bloodLvl.hour,
                yValueMapper: (DailyData bloodLvl, _) => bloodLvl.bloodLvl
              )]
        )
      
      ));
  }
}

class DailyData {
  DailyData(this.hour, this.bloodLvl);
  final String hour;
  final double bloodLvl;
}

class WeeklyGraph extends StatelessWidget{
  const WeeklyGraph({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
           primaryXAxis: CategoryAxis(),
            series: <LineSeries<WeeklyData, String>>[
              LineSeries<WeeklyData, String>(
                // Bind data source
                dataSource:  <WeeklyData>[
                  WeeklyData('Sun', 30),
                  WeeklyData('Mon', 23),
                  WeeklyData('Tues', 40),
                  WeeklyData('Wed', 42),
                  WeeklyData('Thurs', 30),
                  WeeklyData('Fri', 36),
                  WeeklyData('Sat', 39)
                ],
                xValueMapper: (WeeklyData bloodLvl, _) => bloodLvl.day,
                yValueMapper: (WeeklyData bloodLvl, _) => bloodLvl.bloodLvl
              )]
        )
      
      ));
  }
}

class WeeklyData {
  WeeklyData(this.day, this.bloodLvl);
  final String day;
  final double bloodLvl;
}

class MonthlyGraph extends StatelessWidget{
  const MonthlyGraph({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
           primaryXAxis: CategoryAxis(),
            series: <LineSeries<MonthlyData, String>>[
              LineSeries<MonthlyData, String>(
                // Bind data source
                dataSource:  <MonthlyData>[
                  MonthlyData('W1', 44),
                  MonthlyData('W2', 46),
                  MonthlyData('W3', 40),
                  MonthlyData('W4', 42),
                ],
                xValueMapper: (MonthlyData bloodLvl, _) => bloodLvl.week,
                yValueMapper: (MonthlyData bloodLvl, _) => bloodLvl.bloodLvl
              )]
        )
      
      ));
  }
}

class MonthlyData {
  MonthlyData(this.week, this.bloodLvl);
  final String week;
  final double bloodLvl;
}

