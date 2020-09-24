import 'package:flutter/material.dart';
import 'home.dart';
import 'listposts.dart';
void main() {
  runApp(
MaterialApp(
      title: 'Named Routes Demo',

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    )
  );
}