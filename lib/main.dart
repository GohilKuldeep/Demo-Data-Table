import 'package:flutter/material.dart';

import 'dataTable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo Data Table",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Demo Data Table",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Colors.blue,elevation: 0,),
        body: const DataTableScreen(),
      ),
    );
  }
}