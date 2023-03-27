import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Authentication extends StatefulWidget {
  //const Authentication({super.key});

  @override
  State<Authentication> createState() =>
      _Authentication();
}

class _Authentication extends State<Authentication> {
  late TextEditingController _passCodeController;
  late FixedExtentScrollController _scrollController;
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL('https://alphaprototy-default-rtdb.firebaseio.com/');

void _activateListeners() async{
  _database.child("omargrant/Passcode").onValue.listen((event) {
    final String pass = event.snapshot.value.toString();
    if (pass != null)(
   setState(() {
      _passCodeController.text = '$pass';
    }));
  });

  _database.child("omargrant/Passcode").onValue.listen((event) {
    final String _timer = event.snapshot.value.toString();
    if (_timer != null)(
   setState(() {
      timer: _timer; 
    }));
  });
  }

  @override
  void initState() {
    super.initState();
     _activateListeners();
    _passCodeController = TextEditingController();
    _scrollController = FixedExtentScrollController();
  }

   Duration timer = const Duration();

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

    Widget _buildCountdownTimerPicker(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
           //_scrollController.dispose();
          _scrollController = FixedExtentScrollController();
          
          _showDemoPicker(
            context: context,
            child: _BottomPicker(
              child: CupertinoTimerPicker(
                backgroundColor:
                    CupertinoColors.systemBackground.resolveFrom(context),
                initialTimerDuration: timer,
                onTimerDurationChanged: (newTimer) {
                  setState(() => timer = newTimer);
                   _database.child('omargrant').update({"Timer":'${timer.inHours}:'
              '${(timer.inMinutes % 60).toString().padLeft(2, '0')}:'
              '${(timer.inSeconds % 60).toString().padLeft(2, '0')}'});
                },
              ),
            ),
          );
        },
        child: _Menu(
          children: [
            DefaultTextStyle(
            child: Text('Measurement Time Limit'),
            style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
            DefaultTextStyle(
              child: Text(
              '${timer.inHours}:'
              '${(timer.inMinutes % 60).toString().padLeft(2, '0')}:'
              '${(timer.inSeconds % 60).toString().padLeft(2, '0')}'),
              style: const TextStyle(fontSize:16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }


    @override
      Widget build(BuildContext context) {
        final accountRef = _database.child('omargrant');
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle:Text("Authentication")
          ),
          child: SafeArea(
            child: Column(
            children: <Widget>[
            SizedBox(height: 30),
            Container(
              color: Colors.white,
              child: Column(
                children:[ 
                _buildCountdownTimerPicker(context),
                CupertinoTextField(
            //onSaved: widget.onSaved,
            prefix: 
              Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                child: Text("Passcode"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,color: Colors.black)),
             ),
              
              suffix: 
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white),
              textInputAction: TextInputAction.next,
              placeholder: 'Passcode',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              clearButtonMode: OverlayVisibilityMode.editing,
              controller: _passCodeController,
              onEditingComplete: () {
                accountRef.update({'Passcode':_passCodeController.text});
              }, 
              keyboardType: TextInputType.number,
              maxLength: 4,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12)),

                ]
            ))])));
            }}
  
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