import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import "CreateAccount.dart" as createAcc;

class Settings extends StatefulWidget {
 // const Settings({super.key});

  @override
  State<Settings> createState() =>
      _Settings();
}

class _Settings extends State<Settings> {
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late FixedExtentScrollController _scrollController;
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');
  DateTime date = DateTime.now();

  // Value that is shown in the date picker in time mode.
  DateTime time = DateTime.now();

  // Value that is shown in the date picker in dateAndTime mode.
  DateTime dateTime = DateTime.now();

  final items = [
    'Atlantic (AST)',
    'Alaskan (AKST)',
    'Central (CST)',
    'Eastern (EST)',
    'Mountain (MST)',
    'Pacific (PST)',
  ];

  int index = 0;

  void _showDemoPicker({
    required BuildContext context,
    required Widget child,
  }) {
    final themeData = CupertinoTheme.of(context);
    final dialogBody = CupertinoTheme(
      data: themeData,
      child: child,
    );
  showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => dialogBody,
    );
  }
  @override
  void initState() {
    _activateListeners();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _scrollController = FixedExtentScrollController(initialItem: index);
  }

  void _activateListeners() async{
  _database.child("omargrant/Email").onValue.listen((event) {
    final String email = event.snapshot.value.toString();
    if (email != null)(
    setState(() {
      _emailController.text = '${email}';
    }));
   });
   _database.child("omargrant/Phone").onValue.listen((event) {
    final String phone = event.snapshot.value.toString();
    if (phone != null)(
    setState(() {
      _phoneController.text = '${phone}';
    }));
   });
   }

  Widget _buildTimeZonePicker(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _scrollController.dispose();
          _scrollController = FixedExtentScrollController(initialItem: index);
          _showDemoPicker(
            context: context,
            child: _BottomPicker(
              child: CupertinoPicker(
                scrollController: _scrollController,
                onSelectedItemChanged: (index){
                  setState(() =>this.index = index
                  );
                },
                itemExtent: 64,
                children: items
                  .map((item) => Center(
                    child: Text(item),
                  ))
                  .toList(),
                  
                backgroundColor:
                    CupertinoColors.systemBackground.resolveFrom(context),
                  )),
                  );
                },
          
          child: _Menu(children: [
            DefaultTextStyle(
              child: Text('Time Zone'), 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,color: Colors.black)),
            DefaultTextStyle(
              child: Text(items[index]),
              style: const TextStyle(color: Colors.blue, fontSize:16),
            ),
          ]),
        ));
      

    }
@override
  Widget build(BuildContext context) {
     final accountRef = _database.child('omargrant');
    //final localizations = GalleryLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings")
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
                child: Text("Email Address"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              suffix: 
              Container(
                padding: const EdgeInsets.all(3)),
              restorationId: 'email_address_text_field',
              textInputAction: TextInputAction.next,
              placeholder: 'Email Address',
              controller: _emailController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              onEditingComplete: () {
                accountRef.update({'Email':_emailController.text});
              }, 
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
                padding: const EdgeInsets.all(3),
                color: Colors.white),
              textInputAction: TextInputAction.next,
              placeholder: 'Phone Number',
              textAlign: TextAlign.right,
              controller: _phoneController,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),

                   
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            )),
              child: Row(children: [
                SizedBox(width:8),
              TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePassword()));},
              child: Text("Change Password                                                >  ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)))
            ],)
            ),

            Container(
          color: Colors.white,
          child: Column(
            children:[ 
            _buildTimeZonePicker(context),

            
            ]))])));
        
  }}

class ChangePassword extends StatefulWidget {
  //const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() =>
      _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://bmecapstonetest-default-rtdb.firebaseio.com/');
  late TextEditingController _passController;
  late TextEditingController _confirmController;
  @override
  void initState() {
    super.initState();
    _passController = TextEditingController(text: '');
    _confirmController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
       navigationBar: const CupertinoNavigationBar(
        middle: Text("Change Password")
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
                decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
              bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
            ),
          ),
                child: DefaultTextStyle(
                  child: Text("New Password"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              obscureText: true,
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              textAlign: TextAlign.right,
              controller: _passController,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
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
              clearButtonMode: OverlayVisibilityMode.editing,
              suffix: 
              Container(
                padding: const EdgeInsets.all(8)),
              textAlign: TextAlign.right,
              controller: _confirmController,
              textDirection: TextDirection.rtl,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),
              SizedBox(height:50),
              Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  if (_confirmController.text == _passController.text && _passController.text != ''){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Settings()));
                      _database.child('Account/viviaantan').update({'Password':_passController.text});
                    };
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ),
            ),
  ])));}
}

class _BottomPicker extends StatelessWidget {
  const _BottomPicker({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22,
        ),
        child: GestureDetector(
          onTap: (
          ) {},
          child: SafeArea(
            top: false,
            child: child,
          ),
        )
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
          bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
        ),
      ),
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
          ),
      ),
    );
  }
}
