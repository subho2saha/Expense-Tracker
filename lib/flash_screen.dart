import 'dart:html';

import 'package:expense_tracker/start_pro.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    delayed();
    super.initState();
  }

  void delayed() {
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const start_pro(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/image/logo2.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                "\" Beware of little expenses; \n a small leak will sink a great ship.\" ",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu')),
            SizedBox(
              height: 5,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
