import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/restourant_surabaya/main_screen.dart';

void main() {
  runApp(
    DevicePreview(
    enabled:!kReleaseMode,
    builder: (context) => MyApp(), 
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme mode

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber[300], // Light theme AppBar color
        ),
        scaffoldBackgroundColor: Colors.white, // Light theme background color
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Dark theme AppBar color
        ),
        scaffoldBackgroundColor: Colors.black, // Dark theme background color
      ),
      themeMode: _themeMode, // Apply theme mode
      home: MainScreen(toggleTheme: _toggleTheme), // Pass _toggleTheme function here
    );
  }
}