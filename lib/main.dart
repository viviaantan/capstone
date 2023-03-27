import 'dart:async';
import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'RecordPage.dart';
import 'SummaryPage.dart';
import 'AccountPage.dart';
import 'firebase_options.dart';
import 'CreateAccount.dart' as createAcc;
import 'firebaseStorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//BluetoothDevice device;
//BluetoothState state;
//BluetoothDeviceState deviceState;

//void main()  => runApp(capstone_app());
void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp (capstone_app());
}

class capstone_app extends StatefulWidget {
  capstone_app({Key? key}) : super(key: key);
 // final createAcc.User user;
  //capstone_app({required this.user});
  @override
  State<capstone_app> createState() => _capstone_app();
}

class _capstone_app extends State<capstone_app> {
 // const capstone_app({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: LoginDemo(),
      title: 'BME Capstone UI Layout',
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  late TextEditingController _userTextController;
  late TextEditingController _passTextController;
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com');

  void initState() {
    super.initState();
    _userTextController = TextEditingController();
    _passTextController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        title: Text("Login Page"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0, left:20),
              child: Center(
                child: Container(
                    width: 200,
                    height: 80,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    
                    child: Text("Glucose Monitor",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)),
                    )
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter email address or username'),
                    controller: _userTextController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                    controller: _passTextController,
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                 /*_database.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                void onDataChange(DataSnapshot snapshot) {
                  if (snapshot.hasChild("name")) {
                    // run some code
                  }
                }
              });*/
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyStatefulWidget()));
              },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(
              child:Text('New User? Create Account'),
              onPressed: (){
                Navigator.push(
                      context, MaterialPageRoute(builder: (_) => createAcc.CreateAccount()));
              },)
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
 //.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
    int _selectedIndex = 0;
    static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static List<Widget> _widgetOptions = <Widget>[
    
    // RECORD TAB
    RecordPage(),
  
    // SUMMARY TAB
    SummaryPage(),

    // MY ACCOUNT TAB
    AccountPage(user: new createAcc.User("omargrant")),
    ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Monitor'),
        automaticallyImplyLeading: false,
      ),
       body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.smallcircle_fill_circle),
            label: 'RECORD',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_square),
            label: 'Summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle_fill),
            label: 'My Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}