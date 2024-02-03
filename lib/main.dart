import 'package:expense_tracker/bloc/expense_bloc.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:expense_tracker/screens/onbording%20screens/splace_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ExpenseBloc(db: AppDatabase()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Corrected here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expenso Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // bloc add bloc package
        home: const SplashScreen());
  }
}
