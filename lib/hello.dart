import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class Sign extends StatefulWidget {
  const Sign({ Key? key }) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hello There!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,fontFamily: 'Ubuntu'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Automatic identity verification which enable you to verify your identity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontFamily: 'Ubuntu'
                      ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage('asset/image/reading3.jpg'))
                ),
              ),
              SizedBox(
                    height: 50,
                  ),
                MaterialButton(
                    minWidth: double.infinity,
                    height:60,
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginPage(),));
                    },
                    color: Colors.indigoAccent[400],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Text("Login",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Ubuntu'
                    ),
                    ),
                ),
                SizedBox(
                    height: 15,
                  ),
                MaterialButton(
                      minWidth: double.infinity,
                      height:60,
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  SignupPage(),));
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Text("Sign UP",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Ubuntu'

                      ),),
                    ),	
   
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}