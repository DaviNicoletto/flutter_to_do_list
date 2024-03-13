import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/todo_constants.dart';
import 'package:flutter_to_do_list/home_page.dart';

class MyApp extends StatelessWidget {
  final Key? app;
  const MyApp({this.app}) : super(key: app);

  @override
  Widget build(BuildContext context) {
    final TodoConstants constants = TodoConstants();
    return MaterialApp(
        title: constants.appTitle,
        home: const HomePage(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.cyan),
          
            ),
          );
        
  }
}
