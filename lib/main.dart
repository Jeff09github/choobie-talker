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

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  //BUG TO FIX
  //=> CLOSING BLOC PROVIDER AND CREATING AGAIN WILL NOT UPDATE STATE INSIDE "SPEECH TO TEXT ON STATUS CHANGED FUNCTION" MAKING LISTEN STOP AND WILL NOT LOOP
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
