import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.white, brightness: Brightness.dark);

  //BUG TO FIX
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        // colorScheme: colorScheme,
        // scaffoldBackgroundColor: colorScheme.background,
        // appBarTheme: AppBarTheme(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
