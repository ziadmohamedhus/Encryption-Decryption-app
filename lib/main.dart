import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Stert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: HexColor('56374C'),centerTitle: true),
        backgroundColor: HexColor('E6D1D8'),
          
        primarySwatch: Colors.brown,
      ),
      home: Start(),
    );
  }
}

