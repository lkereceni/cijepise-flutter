import 'package:flutter/material.dart';

class FirstDoseScreen extends StatefulWidget {
  FirstDoseScreen({Key key}) : super(key: key);

  @override
  _FirstDoseScreenState createState() => _FirstDoseScreenState();
}

class _FirstDoseScreenState extends State<FirstDoseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Prva doza'),
        ),
      ),
    );
  }
}
