import 'package:flutter/material.dart';
import 'package:google_ai/screens/home/home.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Generative AI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}



