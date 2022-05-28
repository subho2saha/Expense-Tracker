import 'package:expense_tracker/datastore.dart';
import 'package:expense_tracker/flash_screen.dart';
import 'package:expense_tracker/google_sign-in.dart';
import 'package:expense_tracker/hello.dart';
import 'package:expense_tracker/start_pro.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailkey = GlobalKey<FormState>();
  final passwordkey = GlobalKey<FormState>();
  final conpasswordkey = GlobalKey<FormState>();

//  final String _check;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conpasswordController = TextEditingController();

  void _enterTransactionsign() {
    GooglesheetApi_sign.insert(
      _emailController.text,
      _passwordController.text,
    );
    setState(() {});
  }

  void _Continue() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                  title: Text('Successfully sign-up..',style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu'),),
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.grey[200],
                      child: Text('Continue',
                          style: TextStyle(color: Colors.black, fontFamily: 'Ubuntu') ),
                          
                      onPressed: () {
                        Navigator.pushReplacement(context,(MaterialPageRoute(builder: (context) => Home())));
                        
                      },
                    ),
                  ]
                );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sign(),
                  ));
            },
            icon: Icon(
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
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create an Account, Its free",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: emailkey,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
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
                                    return "Enter correct email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: passwordkey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
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
                                validator: (value) {
                                  if (value != null && value.length < 6) {
                                    // _check = value1 ;
                                    return "atleast 6 digit required";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: conpasswordkey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                obscureText: true,
                                controller: _conpasswordController,
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Confirm password",
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
                                      _passwordController.text !=
                                          _conpasswordController.text) {
                                    return "Must be same as previuos password";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black))),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            final email_check =
                                emailkey.currentState!.validate();
                            final password_check =
                                passwordkey.currentState!.validate();
                            final conpasswordkey =
                                passwordkey.currentState!.validate();

                            if (email_check &&
                                password_check &&
                                conpasswordkey) {
                              Datastore.storeflag(true);
                              _enterTransactionsign();
                                _Continue();
                              // Navigator.pushReplacement(context,(MaterialPageRoute(builder: (context) => Home())));
                            }
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ", style: TextStyle( fontFamily: 'Ubuntu'),),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
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
