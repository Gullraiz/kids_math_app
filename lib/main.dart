import 'package:flutter/material.dart';

import 'screens/kids_home_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Math App',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: KidsHomePage(),
    );
  }
}
