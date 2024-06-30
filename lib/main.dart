import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen.dart';
import 'provider/provider.dart';

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
        title: 'uanq',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(249, 247, 247, 1), // Warna utama
          scaffoldBackgroundColor:
              const Color.fromRGBO(249, 247, 247, 1), // Warna latar belakang
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 63, 114, 175), // Warna AppBar
            centerTitle: true, // Posisikan judul di tengah
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(249, 247, 247, 1), // Warna judul putih
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            iconTheme: IconThemeData(color: Colors.black), // Warna ikon AppBar
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
              foregroundColor: const Color.fromARGB(255, 219, 226, 239),
              backgroundColor: const Color.fromARGB(255, 63, 114, 175),
              textStyle: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
