import 'package:flutter/material.dart';
import 'package:goolemap_app/google-search-places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amberAccent
      ),
     home: GoogleSearchPlaces(),
    );
  }
}
