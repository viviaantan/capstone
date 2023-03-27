import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter/cupertino.dart';

class Notifications extends StatefulWidget {
 // const Notifications({super.key});

  @override
  State<Notifications> createState() =>
      _Notifications();
}

class _Notifications extends State<Notifications> {
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

void checkBoxCallBack(bool? checkBoxState) {
    if (checkBoxState != null) {
      setState(() {
        isChecked = checkBoxState;
        if (isChecked == true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MeasurementReminders()));
        }
      });
    }
  }

  void checkBoxCallBack1(bool? checkBoxState1) {
    if (checkBoxState1 != null) {
      setState(() {
        isChecked1 = checkBoxState1;
      });
    }
  }

  void checkBoxCallBack2(bool? checkBoxState2) {
    if (checkBoxState2 != null) {
      setState(() {
        isChecked2 = checkBoxState2;
      });
    }
  }

  void checkBoxCallBack3(bool? checkBoxState3) {
    if (checkBoxState3 != null) {
      setState(() {
        isChecked3 = checkBoxState3;
      });
    }
  }

 @override
  Widget build(BuildContext context) {
   return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle:Text("My Profile")
      ),
      child: SafeArea(
        child: Column(
        children: <Widget>[
        SizedBox(height: 20),

        Material(child: 
        ListTile(
        leading: 
        TaskCheckBox(
        checkBoxState: isChecked,
        toggleCheckBoxState: checkBoxCallBack,
      ),
       title: Text(
        'Measurement Reminders',
        style: TextStyle(
          decoration: isChecked ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      )),

      Material(child: 
        ListTile(
        leading: 
        TaskCheckBox1(
        checkBoxState1: isChecked1,
        toggleCheckBoxState1: checkBoxCallBack1,
      ),
       title: Text(
        'Daily Updates',
        style: TextStyle(
          decoration: isChecked1 ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      )),

      Material(child: 
        ListTile(
        leading: 
        TaskCheckBox2(
        checkBoxState2: isChecked2,
        toggleCheckBoxState2: checkBoxCallBack2,
      ),
       title: Text(
        'Weekly Updates',
        style: TextStyle(
          decoration: isChecked2 ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      )),
      
      Material(child: 
        ListTile(
        leading: 
        TaskCheckBox3(
        checkBoxState3: isChecked3,
        toggleCheckBoxState3: checkBoxCallBack3,
      ),
       title: Text(
        'Monthly Updates',
        style: TextStyle(
          decoration: isChecked3 ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      )),

      ])));}}
         

class TaskCheckBox extends StatelessWidget {
  final bool checkBoxState;
  final ValueChanged<bool?> toggleCheckBoxState;

  const TaskCheckBox({
    required this.checkBoxState,
    required this.toggleCheckBoxState,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState,
      onChanged: toggleCheckBoxState,
    );
  }
}

class TaskCheckBox1 extends StatelessWidget {
  final bool checkBoxState1;
  final ValueChanged<bool?> toggleCheckBoxState1;

  const TaskCheckBox1({
    required this.checkBoxState1,
    required this.toggleCheckBoxState1,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState1,
      onChanged: toggleCheckBoxState1,
    );
  }
}

class TaskCheckBox2 extends StatelessWidget {
  final bool checkBoxState2;
  final ValueChanged<bool?> toggleCheckBoxState2;

  const TaskCheckBox2({
    required this.checkBoxState2,
    required this.toggleCheckBoxState2,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState2,
      onChanged: toggleCheckBoxState2,
    );
  }
}

class TaskCheckBox3 extends StatelessWidget {
  final bool checkBoxState3;
  final ValueChanged<bool?> toggleCheckBoxState3;

  const TaskCheckBox3({
    required this.checkBoxState3,
    required this.toggleCheckBoxState3,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState3,
      onChanged: toggleCheckBoxState3,
    );
  }
}

class Trends extends StatelessWidget {
  final bool checkBoxState4;
  final ValueChanged<bool?> toggleCheckBoxState4;

  const Trends({
    required this.checkBoxState4,
    required this.toggleCheckBoxState4,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState4,
      onChanged: toggleCheckBoxState4,
    );
  }
}

class Custom extends StatelessWidget {
  final bool checkBoxState5;
  final ValueChanged<bool?> toggleCheckBoxState5;

  const Custom({
    required this.checkBoxState5,
    required this.toggleCheckBoxState5,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blue,
      value: checkBoxState5,
      onChanged: toggleCheckBoxState5,
    );
  }
}
         
class MeasurementReminders extends StatefulWidget {
  //const MeasurementReminders({super.key});

  @override
  State<MeasurementReminders> createState() =>
      _MeasurementRem();
}

class _MeasurementRem extends State<MeasurementReminders> {
    bool isChecked = false;
    bool isChecked1 = false;

  void checkBoxCallBack(bool? checkBoxState4) {
    if (checkBoxState4 != null) {
      setState(() {
        isChecked = checkBoxState4;
        if (isChecked == true){
          TaskCheckBox(checkBoxState: isChecked,
        toggleCheckBoxState: checkBoxCallBack);
        isChecked1 = false;
        Custom(checkBoxState5: isChecked1,
        toggleCheckBoxState5: checkBoxCallBack);
        if (isChecked & isChecked1 == false){
        TaskCheckBox(checkBoxState: isChecked1,
        toggleCheckBoxState: checkBoxCallBack1);
        }
        }
    });
  }}
  
  void checkBoxCallBack1(bool? checkBoxState5) {
    if (checkBoxState5 != null) {
      setState(() {
        isChecked1 = checkBoxState5;
        if (isChecked1 == true){
          TaskCheckBox(checkBoxState: isChecked1,
        toggleCheckBoxState: checkBoxCallBack1);
        isChecked = false;
        Trends(checkBoxState4: isChecked,
        toggleCheckBoxState4: checkBoxCallBack1);
        _buildCountdownTimerPicker(context);
        }

        if (isChecked & isChecked1 == false){
        TaskCheckBox(checkBoxState: isChecked1,
        toggleCheckBoxState: checkBoxCallBack1);
        }
    });
  }}

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
          _showDemoPicker(
            context: context,
            child: _BottomPicker(
              child: CupertinoTimerPicker(
                backgroundColor:
                    CupertinoColors.systemBackground.resolveFrom(context),
                initialTimerDuration: timer,
                onTimerDurationChanged: (newTimer) {
                  setState(() => timer = newTimer);
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle:Text("Measurement Reminders")
      ),
      child: SafeArea(
        child: Column(
        children: <Widget>[
        SizedBox(height: 20),

        Material(child: 
        ListTile(
        leading: 
        Trends(
        checkBoxState4: isChecked,
        toggleCheckBoxState4: checkBoxCallBack,
      ),
      
       title: Text(
        'Based on Trends',
        style: TextStyle(
          decoration: isChecked ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      )),

      Material(child: 
        ListTile(
        leading: 
        Custom(
        checkBoxState5: isChecked1,
        toggleCheckBoxState5: checkBoxCallBack1,
      ),
      
       title: Text(
        'Custom',
        style: TextStyle(
          decoration: isChecked1 ? TextDecoration.underline : null,
          fontWeight: FontWeight.bold
        ),
      ),
      ))
      
      ])));
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