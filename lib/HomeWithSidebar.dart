import 'package:expense_tracker/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'google_sheet_api.dart';

class HomeWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSidebar(),
    );
  }
}

class homeWithSidebar extends StatefulWidget {
  const homeWithSidebar({Key? key}) : super(key: key);
  @override
  _homeWithSidebarState createState() => _homeWithSidebarState();
}

class _homeWithSidebarState extends State<homeWithSidebar>
    with TickerProviderStateMixin {
  bool sideBarActive = false;
  late AnimationController rotationController;
   // collect user input step-1
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet step-2
  void _enterTransaction() {
    GooglesheetApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    
    rotationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f3f6),
      body:
         Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(30)),
                          color: Colors.grey[300]),
                      child: Center(
                          child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              Text('N E W  T R A N S A C T I O N',
                                    style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Text('Expense',
                                    style: TextStyle(fontFamily: 'Ubuntu',fontWeight: FontWeight.w300)),
                              Switch(
                                value: _isIncome,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isIncome = newValue;
                                  });
                                },
                              ),
                              Text('Income',
                                    style: TextStyle(fontFamily: 'Ubuntu',fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Amount?',
                                    ),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Enter an amount';
                                      }
                                      return null;
                                    },
                                    controller: _textcontrollerAMOUNT,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'For what?',
                                  ),
                                  controller: _textcontrollerITEM,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(height: 50,),
                              MaterialButton(
                                color: Colors.grey[600],
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.white,fontFamily: 'Ubuntu')),
                                onPressed: () {
                                  closeSideBar();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                color: Colors.grey[600],
                                child: Text('Enter',
                                    style: TextStyle(color: Colors.white,fontFamily: 'Ubuntu')),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // step 2
                                    _enterTransaction();
                                    closeSideBar();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      ),
                      
                    ),
                  
                  ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context,(MaterialPageRoute(builder: (context) => LoginPage())));
                      }, child: const Text("Log out", style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: 'Ubuntu'))),
                      const SizedBox(height: 5,),
                      IconButton(onPressed: (() {
                        showDialog(context: context, builder: (context) => const AboutDialog(
                          applicationName: "Expense Tracker",
                          applicationVersion: "0.0.1",
                          applicationIcon: Image(image: AssetImage('asset/image/money-transfer.png'),
                          height: 80,),
                        ) );
                      }), icon: Icon(Icons.info_outline))
                    ],
                  ),
                 
                )
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.7 : 0,
              top: (sideBarActive) ? MediaQuery.of(context).size.height * 0.3 : 0,
              child: RotationTransition(
                turns: (sideBarActive)
                    ? Tween(begin: -0.05, end: 0.0).animate(rotationController)
                    : Tween(begin: 0.0, end: -0.05).animate(rotationController),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: (sideBarActive)
                      ? MediaQuery.of(context).size.height * 0.7
                      : MediaQuery.of(context).size.height,
                  width: (sideBarActive)
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: HomePage(),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 50,
              left: 50,
              bottom: 10,
              child: (sideBarActive)
                  ? IconButton(
                      padding: EdgeInsets.all(12),
                      onPressed: closeSideBar,
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    )
                  : InkWell(
                      onTap: openSideBar,
                      child: Container(
                        margin: EdgeInsets.all(17),
                        height: 20,
                        width: 20,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage('asset/images/menu.png')
                                
                        //         )
                        //         ),
                      ),
                    ),
            )
          ],
        ),
      
    );
  }
  
  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }
}
