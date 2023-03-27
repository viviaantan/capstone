import 'package:capstone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class CreateAccount extends StatefulWidget {
 // const Settings({super.key});

  @override
  State<CreateAccount> createState() =>
      _CreateAccount();
}

class User{
  final String user;
  User (this.user);
}

class _CreateAccount extends State<CreateAccount> {
  late TextEditingController _emailTextController;
  late TextEditingController _userTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _passTextController;
  late TextEditingController _confirmPassTextController;
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController(text: '');
    _userTextController = TextEditingController(text: '');
    _phoneTextController = TextEditingController(text: '');
    _passTextController = TextEditingController(text: '');
    _confirmPassTextController = TextEditingController(text: '');
  }

  void getUser(user){
    String user = _userTextController.text;
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _userTextController.dispose();
    _phoneTextController.dispose();
    _passTextController.dispose();
    _confirmPassTextController.dispose();
    super.dispose();
  }


@override
  Widget build(BuildContext context) {
    //final localizations = GalleryLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Create Account")
      ),
      child: SafeArea(
        child: Column(
        children: <Widget>[
        SizedBox(height: 30),

        CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                child: Text("Username"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              restorationId: 'username_text_field',
              textInputAction: TextInputAction.next,
              placeholder: 'Username',
              controller: _userTextController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),),

        CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                child: Text("Email Address"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              restorationId: 'email_address_text_field',
              textInputAction: TextInputAction.next,
              placeholder: 'Email Address',
              controller: _emailTextController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),),
           
        CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                child: Text("Phone Number"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,color: Colors.black)),
             ),
              suffix: 
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white),
              textInputAction: TextInputAction.next,
              placeholder: 'Phone Number',
              controller: _phoneTextController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),

                   
            CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
                child: DefaultTextStyle(
                  child: Text("Password"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              obscureText: true,
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.next,
              placeholder: 'Password',
              controller: _passTextController,
              textDirection: TextDirection.rtl,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),

            CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
                child: DefaultTextStyle(
                  child: Text("Confirm Password"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              obscureText: true,
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.next,
              controller: _confirmPassTextController,
              placeholder: 'Confirm Password',
              
              textDirection: TextDirection.rtl,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),
        SizedBox (height: 80),
        Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  if (_confirmPassTextController.text == _passTextController.text && _passTextController.text != '' && _userTextController!=''){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyStatefulWidget()));
                      _database.child('${_userTextController.text}').update({'Email': _emailTextController.text});
                      _database.child('${_userTextController.text}').update({'Phone':_phoneTextController.text});
                      _database.child('${_userTextController.text}').update({'Password':_passTextController.text});
                    };
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ),
            ),
    
    ])));
  }}
