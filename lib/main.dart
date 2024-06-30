import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'income_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeProvider(),
      child: MaterialApp(
        title: 'Aplikasiku',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(249, 247, 247, 1),
          scaffoldBackgroundColor: Color.fromRGBO(249, 247, 247, 1),
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 63, 114, 175),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontFamily: 'Poppins'),
            bodyLarge: TextStyle(fontFamily: 'Poppins'),
            displayLarge: TextStyle(fontFamily: 'Poppins'),
            displayMedium: TextStyle(fontFamily: 'Poppins'),
            displaySmall: TextStyle(fontFamily: 'Poppins'),
            headlineMedium: TextStyle(fontFamily: 'Poppins'),
            headlineSmall: TextStyle(fontFamily: 'Poppins'),
            titleLarge: TextStyle(fontFamily: 'Poppins'),
            titleMedium: TextStyle(fontFamily: 'Poppins'),
            titleSmall: TextStyle(fontFamily: 'Poppins'),
            bodySmall: TextStyle(fontFamily: 'Poppins'),
            labelLarge: TextStyle(fontFamily: 'Poppins'),
            labelSmall: TextStyle(fontFamily: 'Poppins'),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 219, 226, 239),
              backgroundColor: Color.fromARGB(255, 63, 114, 175),
              textStyle: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
