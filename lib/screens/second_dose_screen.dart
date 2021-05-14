import 'package:flutter/material.dart';

class SecondDoseScreen extends StatefulWidget {
  SecondDoseScreen({Key key}) : super(key: key);

  @override
  _SecondDoseScreenState createState() => _SecondDoseScreenState();
}

class _SecondDoseScreenState extends State<SecondDoseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Druga doza'),
        ),
      ),
    );
  }
}
