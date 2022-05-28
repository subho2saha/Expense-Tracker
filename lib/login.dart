import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:expense_tracker/datastore.dart';
import 'package:expense_tracker/flash_screen.dart';
import 'package:expense_tracker/google_sign-in.dart';
import 'package:expense_tracker/hello.dart';
import 'package:expense_tracker/loading_circle.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email_log_key = GlobalKey<FormState>();
  final password_log_key = GlobalKey<FormState>();

  final TextEditingController _email_log_Controller = TextEditingController();
  final TextEditingController _password_log_Controller =
      TextEditingController();

  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GooglesheetApi_sign.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  void _searchTransaction() async {
    final value = await GooglesheetApi_sign.search(
      _email_log_Controller.text,
      _password_log_Controller.text,
    );
    if (value == "successfull") {
      print("okk");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } else {
      print("miss");
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return AlertDialog(
                      title: const Text(
                        'User not exist or wrong password given!',
                        style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu'),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          color: Colors.grey[200],
                          child: const Text('Cancel',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Ubuntu')),
                          onPressed: () {
                             Navigator.of(context).pop();
                          },
                        ),
                      ]);
                },
              );
            });
      
    }
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     if (GooglesheetApi_sign.loading == true && timerHasStarted == false) {
        startLoading();}
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sign(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back !  Login with your credentials",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: email_log_key,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                controller: _email_log_Controller,
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontFamily: "Ubuntu",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                                validator: (value) {
                                  if (value != null &&
                                      !EmailValidator.validate(value)) {
                                    return "Enter correct Email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: password_log_key,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                obscureText: true,
                                controller: _password_log_Controller,
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Password",
                                    style: TextStyle(
                                      fontFamily: "Ubuntu",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black))),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            final email_log_check =
                                email_log_key.currentState!.validate();
                            final password_log_check =
                                password_log_key.currentState!.validate();

                            if (email_log_check && password_log_check) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("wait for a moment...")));
                              Datastore.storeflag(true);
                              _searchTransaction();
                            }
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont have an account? ",
                          style: TextStyle(fontFamily: 'Ubuntu'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ));
                          },
                          child: const Text(
                            "Sign-up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

