import 'package:elenden/constants/constants.dart';
import 'package:elenden/provider/transaction_provider.dart';
import 'package:elenden/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_page.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),

      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}
