import 'package:flutter/material.dart';
import 'telainicial.dart';

void main() => runApp(MyWeatherApp());

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.tealAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
      },
    );
  }
}
