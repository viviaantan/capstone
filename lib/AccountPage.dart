import 'package:capstone_app/Account_Authen.dart';
import 'package:capstone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter_gen/gen_l10n/gallery_localizations.dart";
import 'Account_Profile.dart';
import 'Account_Settings.dart';
import 'Account_Notifs.dart';
import 'package:firebase_database/firebase_database.dart';
import "CreateAccount.dart" as createAcc;


class AccountPage extends StatefulWidget {
  final createAcc.User user;
  AccountPage({Key, key, required this.user}): super(key: key);

  @override
  State<AccountPage> createState() =>
      _AccountPage();
}

class _AccountPage extends State<AccountPage>{
String _displayText = '';
late TextEditingController _nameTextController;
final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');

void _activateListeners() async{
  _database.child("omargrant/Name").onValue.listen((event) {
    final String name = event.snapshot.value.toString();
    setState(() {
      _nameTextController.text = '$name';
    });
   });
  }
@override
  void initState() {
    super.initState();
     _activateListeners();
    _nameTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
        SizedBox(height: 30),
        Row(children: [
          SizedBox(width: 20),
          Text(_nameTextController.text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ]),
        SizedBox(height: 30),
        Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(width:13),
              TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProfile(user: new createAcc.User(_nameTextController.text))));},
              child: 
              Container(
                child:Row(
                children: [Icon(CupertinoIcons.person_alt_circle_fill), 
                SizedBox(width: 10),
                Text("My Profile                                                           ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))]))
              )])
            ),
             //SizedBox(height: 30),
        Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(width:13),
              TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));},
              child: Row(
                children: [Icon(CupertinoIcons.gear),
                SizedBox(width: 10),
                Text("Settings                                                              ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))]))
            ])
            ),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(width:13),
              TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> Authentication()));},
              child: Row(
                children: [Icon(CupertinoIcons.hand_raised),
                  SizedBox(width: 10),
                  Text("Authentication                                                 ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))]))
            ])
            ),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(width:13),
              TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications()));},
              child: Row(
                children: [Icon(CupertinoIcons.bell),
                  SizedBox(width: 10),
                  Text("Notifications                                                     ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))]))
            ])
            ),
            SizedBox(height:50),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(width:13),
              
                Row(
                children: [
                  DialogExample(),
                  /*Text("Log Out                                                                   ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red))]))*/
            ])
            ]))],
        
        )
        
        );
    
  }
}
class DialogExample extends StatelessWidget {
 // const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions:[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginDemo())),
              child: const Text('Log Out', style: TextStyle(fontSize:16, color: Colors.red)),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel', style: TextStyle(fontSize:16, color: Colors.blue)),
              
            ),
          ],
        ),
      ),
      child: const Text('  Log Out                                                                 ', style: TextStyle(fontSize:16, color: Colors.red)),
    );
  }
}



