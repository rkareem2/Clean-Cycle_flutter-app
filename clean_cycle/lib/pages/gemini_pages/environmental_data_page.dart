import 'package:flutter/material.dart';

class EnvDataPage extends StatefulWidget {
  const EnvDataPage({super.key});
  
  @override
  EnvDataPageState createState() => EnvDataPageState();
}

class EnvDataPageState extends State<EnvDataPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environmental Data'),
      ),
      body: Container(),
    );
  }
}
