import 'package:flutter/material.dart';
import 'package:pruebaapi/src/pages/homepage.dart';
import 'package:pruebaapi/src/pages/personajes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba Api',
      theme: ThemeData(backgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/personajes': (_) => Personajes(),
      },
    );
  }
}
