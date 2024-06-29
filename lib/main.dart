import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'income_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeProvider(),
      child: MaterialApp(
        title: 'Aplikasiku',
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          appBarTheme: AppBarTheme(
            color: Colors.blueGrey,
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.blueGrey),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
