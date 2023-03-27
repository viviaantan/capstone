import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateAccount.dart' as createAcc;

//import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';


class MyProfile extends StatefulWidget {
 // const MyProfile({super.key})
 final createAcc.User user;
 MyProfile({Key, key, required this.user}): super(key: key);

  @override
  State<MyProfile> createState() =>
      _MyProfile();
}
class _MyProfile extends State<MyProfile> {
  late TextEditingController _nameTextController;
  late FixedExtentScrollController _scrollController;
  late FixedExtentScrollController sex_scrollController;
  late TextEditingController _heightTextController;
  late TextEditingController _weightTextController;
  String _displayUser = '';
  String _displayHeight = '';
  String _displayWeight = '';
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');


  DateTime date = DateTime.now();

  // Value that is shown in the date picker in time mode.
  DateTime time = DateTime.now();

  // Value that is shown in the date picker in dateAndTime mode.
  DateTime dateTime = DateTime.now();

  final items = [
    'Female',
    'Male'
  ];

  int index = 0;
  int sexIndex = 0;

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
    super.initState();
     _activateListeners();
     //();
    _nameTextController = TextEditingController();
    _scrollController = FixedExtentScrollController();
    sex_scrollController = FixedExtentScrollController();
    _heightTextController = TextEditingController();
    _weightTextController = TextEditingController();
    
  }

  void _activateListeners() async{
  _database.child("omargrant/Name").onValue.listen((event) {
    final String name = event.snapshot.value.toString();
    if (name != 'null')(
    setState(() {
      _nameTextController.text = '${name}';
    }))
    ;
   });
   _database.child("omargrant/Username").onValue.listen((event) {
    final String username = event.snapshot.value.toString();
    setState(() {
      _displayUser = '${createAcc.User}';
    });
   });
   _database.child("omargrant/Height").onValue.listen((event) {
    final String height = event.snapshot.value.toString();
    if (height != 'null')(
    setState(() {
      _heightTextController.text = '${height}';
    }));
   });
   _database.child("omargrant/Weight").onValue.listen((event) {
    final String weight = event.snapshot.value.toString();
    if (weight != 'null')(
    setState(() {
      _weightTextController.text = '${weight}';
    }));
   });
  }

 /* @override
  void dispose() {
    //_nameTextController.dispose();
    _scrollController.dispose();
    sex_scrollController.dispose();
    super.dispose();
  }*/

Widget _buildDatePicker(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _scrollController.dispose();
          _scrollController = FixedExtentScrollController(initialItem: index);
          _database.child('omargrant').update({"DOB":'${date.month}/${date.day}/${date.year}'});
          _showDemoPicker(
            context: context,
            child: _BottomPicker(
              child: CupertinoDatePicker(
                backgroundColor:
                    CupertinoColors.systemBackground.resolveFrom(context),
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                maximumYear: DateTime.now().year,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (newDateTime) {
                  setState(() => date = newDateTime);
                  _database.child('omargrant').update({"DOB":'${date.month}/${date.day}/${date.year}'});
                },
              ),
            ),
          
          );
          },
        child: _Menu(children: [
          DefaultTextStyle(
            child: Text('Date of Birth'), 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:16 ,color: Colors.black)),
          DefaultTextStyle(
            child: Text(
              '${date.month}/${date.day}/${date.year}'
            ),
            style: const TextStyle(fontSize:16, color: Colors.black),
          ),
        ]),
      ),
    );
  }

  Widget _buildSexPicker(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          sex_scrollController.dispose();
          sex_scrollController = FixedExtentScrollController(initialItem: sexIndex);
           _database.child('omargrant').update({"Sex":'${items[sexIndex]}'});
          _showDemoPicker(
            context: context,
            child: _BottomPicker(
              child: CupertinoPicker(
                onSelectedItemChanged: (sexIndex){
                  setState(() =>this.sexIndex = sexIndex);
                  _database.child('omargrant').update({"Sex":'${items[sexIndex]}'});
                },
                itemExtent: 64,
                children: items
                  .map((item) => Center(
                    child: Text(item),
                  ))
                  .toList(),
                backgroundColor:
                    CupertinoColors.systemBackground.resolveFrom(context),
                
              ),
            ),
          
          );
          },
        child: _Menu(children: [
          DefaultTextStyle(
            child: Text('Sex'), 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:16 ,color: Colors.black)),
          DefaultTextStyle(
            child: Text(items[sexIndex]),
            style: const TextStyle(fontSize:16, color: Colors.black),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountRef = _database.child('omargrant');

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle:Text("My Profile")
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
          ),
                child: DefaultTextStyle(
                  child: Text("Name"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              
              suffix: 
              Container(
                padding: const EdgeInsets.all(3)),
              placeholder: 'Name',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              controller: _nameTextController,
              onEditingComplete: () {
                accountRef.update({'Name':_nameTextController.text});
              }, 
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),),
           
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 0.1))
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          DefaultTextStyle(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black), 
            child: Text("Username")),
            Spacer(),
            DefaultTextStyle(
              textAlign: TextAlign.right,
            style: TextStyle(fontSize:16, color: Colors.blueGrey ), 
            child: Text(_displayUser))
        ],)
        ),
      Container(
          color: Colors.white,
          child: Column(
            children:[ 
            _buildSexPicker(context),
            ])),

      Container(
          color: Colors.white,
          child: Column(
            children:[ 
            _buildDatePicker(context),
            ])),

        CupertinoTextField(
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                  child: Text("Height (cm)"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              suffix: 
              Container(
                padding: const EdgeInsets.all(3)),
              textDirection: TextDirection.rtl,
              controller: _heightTextController,
              placeholder: 'Height',
              textAlign: TextAlign.right,
              clearButtonMode: OverlayVisibilityMode.editing,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                accountRef.update({'Height':_heightTextController.text});
              }, 
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),

          CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
          ),
                child: DefaultTextStyle(
                child: Text("Weight (lb)"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.black))),
              suffix: 
              Container(
                padding: const EdgeInsets.all(3)),
                placeholder: 'Weight',
              textAlign: TextAlign.right,
              controller: _weightTextController,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                accountRef.update({'Weight':_weightTextController.text});
              }, 
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12)),


       ]),
      ),
    );
  }
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
        ),
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

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(100, 42)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_time, size: 28),
            const SizedBox(width: 8),
            Text(
              'Show Picker',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        onPressed: onClicked,
      );
}
