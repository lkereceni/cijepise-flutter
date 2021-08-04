import 'package:flutter/material.dart';

class AntigenicTestScreen extends StatefulWidget {
  AntigenicTestScreen({Key key}) : super(key: key);

  @override
  _AntigenicTestScreenState createState() => _AntigenicTestScreenState();
}

class _AntigenicTestScreenState extends State<AntigenicTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Brzi antigenski test'),
        ),
      ),
    );
  }
}
