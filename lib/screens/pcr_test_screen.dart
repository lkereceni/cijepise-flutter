import 'package:flutter/material.dart';

class PcrTestScreen extends StatefulWidget {
  PcrTestScreen({Key key}) : super(key: key);

  @override
  _PcrTestScreenState createState() => _PcrTestScreenState();
}

class _PcrTestScreenState extends State<PcrTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('PCR test'),
        ),
      ),
    );
  }
}
