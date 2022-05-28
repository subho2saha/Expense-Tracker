import 'package:expense_tracker/HomeWithSidebar.dart';
import 'package:flutter/material.dart';

class start_pro extends StatelessWidget {
  const start_pro({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWithSidebar(),
      routes: {
        '/homePage' : (context)=>HomeWithSidebar(),
      }
   );
  }
}