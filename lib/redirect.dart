import 'package:expense_tracker/datastore.dart';
import 'package:expense_tracker/flash_screen.dart';
import 'package:expense_tracker/hello.dart';
import 'package:flutter/material.dart';

class redirect extends StatefulWidget {
  const redirect({ Key? key }) : super(key: key);

  @override
  State<redirect> createState() => _redirectState();
}

class _redirectState extends State<redirect> {
  @override
  Widget build(BuildContext context) {
    if(Datastore.retriveflag() != true){
      return Sign();
    }
    else{
      return Home();
    }
  }
}