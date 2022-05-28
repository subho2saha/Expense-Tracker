import 'package:expense_tracker/datastore.dart';
import 'package:expense_tracker/google_sheet_api.dart';
import 'package:expense_tracker/google_sign-in.dart';
import 'package:expense_tracker/redirect.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Datastore.init();
  GooglesheetApi_sign().init();
  GooglesheetApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home:  redirect(),
    );
  }
}
