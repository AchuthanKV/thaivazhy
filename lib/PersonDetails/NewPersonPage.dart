//import 'dart:collection';
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:ui';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;

class NewPersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPersonPageState();
  }
}

class _NewPersonPageState extends State<NewPersonPage> {
  final _invitePageState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // ignore: unused_element
    setSelectedState() async {
      // imagedata = (await rootBundle.load('assets/images/circle_check.png'))
      //     .buffer
      //     .asUint8List();
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool isSearching = phoneEditingController.text.isNotEmpty;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                key: _invitePageState,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Center(
                    child: Text(
                      'Add Member',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  bottom: inputFields(),
                ),
                body: TabBarView(
                  children: listOfWidgets(),
                ))));

    /*
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            key: _invitePageState,
                            appBar: AppBar(
                              backgroundColor: Colors.white,
                              title: Center(
                                child: Text(
                                  'Add Member',
                                  style: TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ),
                              bottom: TabBar(
                                tabs: [
                                  Tab(
                                    iconMargin: EdgeInsets.symmetric(horizontal: 100),
                                    icon: Icon(Icons.sms),
                                    child: Text(
                                      'SMS',
                                      style: TextStyle(color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(Icons.email),
                                    child: Text(
                                      'EMAIL',
                                      style: TextStyle(color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: TabBarView(children: listOfWidgets() //listofWidets,
                                ),
                          ),
                        ),
                      );*/
  }

  List<Widget> listOfWidgets() {}

  inputFields() {}
}
