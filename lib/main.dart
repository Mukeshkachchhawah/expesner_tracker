import 'package:expense_tracker/database/db_helper.dart';
import 'package:expense_tracker/ui/onbording%20screens/splace_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.openDB();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
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
