import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:flutter_blue/flutter_blue.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key? key}) : super(key: key);
  //final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  @override
  State<RecordPage> createState() => _RecordPage();
}

class _RecordPage extends State<RecordPage>{
  int _selectedIndex = 0;
  String _displayText = '';
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com');

//final FlutterBlue flutterBlue = FlutterBlue.instance;

/*_addDeviceTolist(final BluetoothDevice device) {
   if (!widget.devicesList.contains(device)) {
     setState(() {
       widget.devicesList.add(device);
     });
   }
 }*/

/* void main () async {
    //replace your restFull API here.
    var url = 'http://127.0.0.1:8000/';
    final http.Client _client = http.Client();
    //final response = await http.get(Uri.parse(url));
    var response = await _client.post(Uri.parse(url),);
    print(response);
  } */

@override
  void initState() {
    super.initState();
    //main();
     _activateListeners();
  }

  void _activateListeners() async{
  _database.child("omargrant/Glucose").onValue.listen((event) {
    final String glucose = event.snapshot.value.toString();
    if (glucose != 'null')(
    setState(() {
      _displayText = '$glucose mg/dL';
    }));
   });
  }
  @override
  Widget build (BuildContext context) {
    const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    return Scaffold(
      body: Column(
      children: [
        SizedBox(width: double.infinity, height: 50),
        Text(style: optionStyle,
        'Record Glucose Level',
        ),
        SizedBox(width: double.infinity, height: 50),
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        child: Row(
            children: [
            Text(
              style: TextStyle(fontSize: 20),
              'Device',
            ),
            Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
              onPressed: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> DeviceName()));
              }, 
              child: const Text(
                'Connected', 
                style: TextStyle(color: Colors.blue)),
                )])),
        SizedBox(width: double.infinity,height: 35),
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Row(
            children: <Widget>[
            Text(
              style: TextStyle(fontSize: 20),
              'Your Glucose Level is'),
              SizedBox(width: 10),
              Text(
                'NORMAL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
              ),
            ],
            ),
        ),
        SizedBox(width: double.infinity,height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Row(
            children: <Widget>[
            Text(
              style: TextStyle(fontSize: 20),
              'Glucose Level',
            ),
            Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const GlucoseLevel()
                
                ));
                }, 
              child: Text(
                '$_displayText>', 
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
                )])),
        SizedBox(width: double.infinity,height: 100),
        ElevatedButton(
          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 40)),
          onPressed:() {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=>  LiveRecord()),

              
              );
            _database.child('Account/viviaantan').update({'Glucose': ""});
          },
          child: const Text('RECORD'),
        ),
        
      ],
    ),    
  );

}
}

/*class DeviceName extends StatelessWidget {
  //const DeviceName({Key? key}) : super(key: key);
  const DeviceName({Key? key, this.result, this.onTap}) : super(key: key);

  final ScanResult? result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result!.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result!.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result!.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result!.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String? getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String? getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result!.rssi.toString()),
      trailing: ElevatedButton(
        child: Text('CONNECT',
        style: TextStyle(color: Colors.black)),
        onPressed: (result!.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result!.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result!.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(
                    result!.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result!.advertisementData.serviceUuids.isNotEmpty)
                ? result!.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result!.advertisementData.serviceData) ?? 'N/A'),
      ],
    );
  }
  }*/

class GlucoseValue {
  final int value;

  GlucoseValue({
    required this.value,
  });
}


class LiveRecord extends StatefulWidget {
  const LiveRecord({super.key});

  @override
  State<LiveRecord> createState() => _LiveRecord();
}

class _LiveRecord extends State<LiveRecord> {
  //int endTime = DateTime.now().millisecondsSinceEpoch + Duration(seconds: 5).inMilliseconds;
  //Timer? timer;
  late Timer _timer;
  int _countdown = 15;

  @override
  void initState() {
    super.initState();
    main();
    _countdown = 15;
    startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void main () async {
    //replace your restFull API here.
    //var url = 'http://127.0.0.1:8000/';
    var url = 'https://2f3e-141-117-116-39.ngrok.io';
    final http.Client _client = http.Client();
    //final response = await http.get(Uri.parse(url));
    var response = await _client.post(Uri.parse(url),);
  }

   // *TODO* add in when progress indicator is in sync with sensor
   /*Timer(
    Duration(minutes: 1),
    ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const MyStatefulWidget())));
    */
  void startTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSecond,
          (Timer timer) => setState(
            () {
          if (_countdown < 1) {
            timer.cancel();
          } else {
            _countdown--;
          }
        },
      ),
    );
  }

  void resetTimer() {
    _timer.cancel();
    _countdown = 15;
    startTimer();
  }

  
  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record'),
      ),
       body: Column(
      children: <Widget> [
        SizedBox(height: 50),
        SizedBox(child: Row(
          children: <Widget>[
          SizedBox(width: 110),
          const SizedBox(width: 0.0, height: 30.0),
          DefaultTextStyle(
              style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
              ),
            child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('Acquiring Signal...'),
          ],
          repeatForever: true,
          
          )),
          
       ])),
       SizedBox(height: 50),
       CircularPercentIndicator(
        radius: 150,
        lineWidth: 20,
        backgroundColor: Colors.grey,
        progressColor: Colors.green,
        percent: 1,
        animation: true,
        center: Text( '%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        circularStrokeCap: CircularStrokeCap.round,
        animationDuration: 15000,
        onAnimationEnd: () => Timer (Duration(seconds: 2),
        ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyStatefulWidget() ))),
        ),
        
       SizedBox(height: 100),
       SizedBox(child: Row(
        children: <Widget>[
        SizedBox(width: 90),
       if (_countdown !=0)...[
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30)),
          onPressed:null,
       child: Text('Try Again | '+_countdown.toString()),
       )]
       else ...[
        ElevatedButton(
          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30)),
          onPressed:(){
            if (_countdown==0){
            resetTimer();
            }
          },
          child: Text('Try Again | '+_countdown.toString()),
        )]
          
       // Text(_countdown.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ]))]));
        }
  }
  


class GlucoseLevel extends StatelessWidget {
  const GlucoseLevel({super.key});

  @override
  Widget build(BuildContext context) {
     return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Glucose Level")
      ),
      child: SafeArea(
      child: Column(
      children: [
        SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
                child: Row(
                children: <Widget>[
                DefaultTextStyle(
                child: Text("Date"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black)),
              Spacer(),
          DefaultTextStyle(
            child: Text('Jan 6, 2023'),
            style: TextStyle(fontSize:16, color: Colors.black)),
            ])),
      Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
          children: <Widget>[
          DefaultTextStyle(
            child: Text('Time'),
            style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold)),
          Spacer(),
          DefaultTextStyle(
            child: Text('11:34 EST'),
            style: TextStyle(fontSize: 16, color: Colors.black)),
            
       ])),
      
      Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
        child: Row(
          children: <Widget>[
          DefaultTextStyle(
            child: Text('Before Meal?'),
            style: TextStyle(fontSize:16, color: Colors.black, fontWeight: FontWeight.bold)),
          Spacer(),
          DefaultTextStyle(
            child: Text('YES'),
            style: TextStyle(fontSize:16, fontWeight: FontWeight.bold, color: Colors.black)),
            
       ])),

       SizedBox(height: 20),
       
       SizedBox(child: Row(
          children: <Widget>[
            SizedBox(width: 20),
            DefaultTextStyle(
              child: Text('Targets'),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, color: Colors.black))
          ])),

          SizedBox(height: 10),

       Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
          child: Row(
          children: <Widget>[
          DefaultTextStyle(
            child: Text('Before Meal'),
            style: TextStyle(fontSize: 16, color: Colors.black)),
          Spacer(),
          DefaultTextStyle(
            child: Text('80 - 130 mg/dL'),
            style: TextStyle(fontSize: 16, color: Colors.black)),
            
       ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
            color: Colors.white,
          ),
        child: Row(
          children: <Widget>[
          DefaultTextStyle(
            child: Text('After Meal'),
            style: TextStyle(fontSize:16, color: Colors.black)),
          Spacer(),
          DefaultTextStyle(
            child: Text('< 180 mg/dL'),
            style: TextStyle(fontSize:16, color: Colors.black)),
            
       ])),
      ]
      )
     ));
  }
}