import 'dart:async';
import 'package:expense_tracker/loading_circle.dart';
import 'package:expense_tracker/plus.dart';
import 'package:expense_tracker/top.dart';
import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'google_sheet_api.dart';
import 'package:gsheets/gsheets.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}




class _homePageState extends State<homePage> {


  // wait for data to be fetched form sheet
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GooglesheetApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (GooglesheetApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(
            backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
           Top(
              balance: (GooglesheetApi.calculateIncome() -
                      GooglesheetApi.calculateExpense())
                  .toString(),
              income: GooglesheetApi.calculateIncome().toString(),
              expense: GooglesheetApi.calculateExpense().toString(),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GooglesheetApi.loading == true ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GooglesheetApi.currentTransactions.length,
                                itemBuilder: (context, index) {
                                  return transaction(
                                      transactionName: GooglesheetApi
                                          .currentTransactions[index][0],
                                      amount: GooglesheetApi
                                          .currentTransactions[index][1],
                                      expenseorIncome: GooglesheetApi
                                          .currentTransactions[index][2]);
                                          
                                }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            plusbutton(
              
            ),
            
          ],
        ),
      ),
    );
  }
  
}