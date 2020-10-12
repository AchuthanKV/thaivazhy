//import 'dart:collection';
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bloodline/PersonDetails/API_URL.dart' as API;
// import 'package:intl/intl.dart' as INTL;
// import 'package:mongo_dart/mongo_dart.dart' as MONGO;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../bin/models/Person.dart';

class NewPersonPage extends StatefulWidget {
  NewPersonPage(BuildContext context);

  //NewPersonPage(BuildContext context);

  @override
  State<StatefulWidget> createState() {
    return _NewPersonPageState();
  }
}

class _NewPersonPageState extends State<NewPersonPage> {
  //final FlutterSecureStorage _storage = FlutterSecureStorage();

  final _newMPageState = GlobalKey<ScaffoldState>();
  final _signupFormKey = GlobalKey<FormState>();
  //final _signupScaffold = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  FocusNode _nameFocus;
  FocusNode _nickNameFocus;
  FocusNode _imageFocus;
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _companyFocus = FocusNode();
  final FocusNode _occupFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();

  String _name;
  String _nickName;
  String _gender;
  String _dobString = "Select date of birth";
  String _company;
  String _occup;
  String _address;
  String _image;
  //List _locations = ['+91', '72'];
  List _genders = ['Male', 'Female', 'Other'];

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController nickNameController = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController companyController = new TextEditingController();
  final TextEditingController occupController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController imageController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameFocus = FocusNode();
    _nickNameFocus = FocusNode();
    _imageFocus = FocusNode();
    // ignore: unused_element
    setSelectedState() async {
      // imagedata = (await rootBundle.load('assets/images/circle_check.png'))
      //     .buffer
      //     .asUint8List();
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _nameFocus.dispose();
    _nickNameFocus.dispose();
    _imageFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool isSearching = phoneEditingController.text.isNotEmpty;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.blue));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.blue[700],
              key: _newMPageState,
              appBar: AppBar(
                backgroundColor: Colors.blueAccent[100],
                title: Center(
                  child: Row(
                    children: <Widget>[
                      //Expanded(
                      //child:
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => {Navigator.pop(context)},
                      ),
                      //),
                      Expanded(
                        child: Text(
                          'New Member',
                          style:
                              TextStyle(color: Colors.blue[700], fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                //bottom: TabBar(tabs: null),
              ),
              body: ListView(
                children: <Widget>[
                  //   logoSection(),
                  //logoTitle(),
                  // headerSection(),
                  textSection(),
                  buttonSection(),
                  //goBackSection()
                  //--inputFields(),
                ],
              ),

              // TabBarView(
              //   children: listOfWidgets(),
              // ),
            )));
  }

  SingleChildScrollView textSection() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Form(
          key: _signupFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _name = value;
                },
                controller: nameController,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_nickNameFocus);
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_box, color: Colors.white70),
                  hintText: "Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _nickNameFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_dobFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter nick Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _nickName = value;
                },
                controller: nickNameController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                  hintText: "Nick Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _companyFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_dobFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a company name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _company = value;
                },
                controller: companyController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_balance, color: Colors.white70),
                  hintText: "Company",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _dobFocus,
                readOnly: true,
                //  onFieldSubmitted: (term) {
                //   FocusScope.of(context).requestFocus(_genderFocus);
                // },
                validator: (value) {
                  if (_dobString == "Select date of birth") {
                    return 'Please select date of Birth';
                  }
                  return null;
                },
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1900),
                      lastDate: new DateTime.now());
                  if (datePick != null) {
                    setState(() {
                      if ('${datePick.month}' != null) {
                        var month = '${datePick.month}'.trim(),
                            day = '${datePick.day}'.trim();

                        if (month.length == 1) {
                          month = '0' + month;
                        }
                        if (day.length == 1) {
                          day = '0' + day;
                        }
                        _dobString =
                            '${datePick.year}-'.trim() + month + '-' + day;
                        //"${datePick.year}${datePick.month}${datePick.day}";
                      }
                    });
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _dobString = "Select date of birth";
                  });
                },
                onSaved: (String value) {},
                controller: dobController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.cake, color: Colors.white70),
                  hintText: _dobString,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 30.0),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blueGrey,
                ),
                child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _gender = value;
                    },
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white70),
                      hintText: "Select Gender",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[600])),
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    items: _genders.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    }),
              ),

              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       flex: 4,
              //       child: TextFormField(
              //         keyboardType: TextInputType.number,
              //         validator: (value) {
              //           if (value.isEmpty) {
              //             return 'Please enter a Phone Number';
              //           }
              //           return null;
              //         },
              //         onSaved: (String value) {
              //           _address = value;
              //         },
              //         controller: addressController,
              //         cursorColor: Colors.white70,
              //         style: TextStyle(color: Colors.white70),
              //         decoration: InputDecoration(
              //           icon: Icon(Icons.phone, color: Colors.white70),
              //           hintText: "Address",
              //           border: UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.white70)),
              //           focusedBorder: UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.yellow[600])),
              //           hintStyle: TextStyle(color: Colors.white70),
              //           //Color(THEME.PRIMARY_COLOR)
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _occupFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_addressFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a occupation ';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _occup = value;
                },
                controller: occupController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.airline_seat_recline_extra,
                      color: Colors.white70),
                  hintText: "Occupation",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _addressFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_imageFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _address = value;
                },
                controller: addressController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.home, color: Colors.white70),
                  hintText: "Address",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                focusNode: _imageFocus,
                onFieldSubmitted: (term) {
                  //FocusScope.of(context).requestFocus(_imageFocus);
                },
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please enter address';
                //   }
                //   return null;
                // },
                onSaved: (String value) {
                  print('image val:  ' + value);
                  if (value == null || value.trim() == '') {
                    _image =
                        'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png?1592828498';
                  } else {
                    _image = value;
                  }
                },
                controller: imageController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.image, color: Colors.white70),
                  hintText: "Image",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                ),
              ),
              // Theme(
              //   data: Theme.of(context).copyWith(
              //     canvasColor: Colors.blueGrey,
              //   ),
              //   child: DropdownButtonFormField(
              //       validator: (value) {
              //         if (value == null) {
              //           return 'Please select Address';
              //         }
              //         return null;
              //       },
              //       onSaved: (value) {
              //         _occup = value;
              //       },
              //       style: TextStyle(color: Colors.white70),
              //       decoration: InputDecoration(
              //         icon: Icon(Icons.language, color: Colors.white70),
              //         hintText: "Select Address",
              //         border: UnderlineInputBorder(
              //             borderSide: BorderSide(color: Colors.white70)),
              //         focusedBorder: UnderlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.yellow[600])),
              //         hintStyle: TextStyle(color: Colors.white70),
              //       ),
              //       items: _occup.map((value) {
              //         return DropdownMenuItem(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           _nationality = value;
              //         });
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (_signupFormKey.currentState.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            _signupFormKey.currentState.save();
            print(_name);
            Map data = {
              'dob': _dobString.replaceAll("-", ""),
              'name': _name,
              'nickName': _nickName,
              'address': _address,
              'occupation': _occup,
              'company': _company,
              'gender': _gender,
              'image': _image,
            };
            print(data);
            setState(() {
              _isLoading = true;
            });
            addNewMember(data);
          }
        },
        textColor: Colors.white,
        elevation: 0.0,
        color: Colors.black,
        child: Text("Add Member", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  void addNewMember(Map data) async {
    Person newMember;
    http.Response response;
    try {
      print('URL: ---- ' + API.MEMBER_URL);
      response = await http.post(
        API.MEMBER_URL,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode(data),
      );
    } on SocketException catch (err) {
      print('Socket Exception:' + err.toString());
    }
    try {
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        //resp = await convert.jsonDecode(response.body);
        //print('RESPONSE :---------------');
        //print(resp);
        final Map parsedPerson = await convert.jsonDecode(response.body);
        newMember = Person.fromJson(parsedPerson);

        print('created Member: ' + newMember.toString());

        //parsedList.map((val) => Person.fromJson(val)).toList();

      }
      // else {
      //   print('Response reason: ' + response.reasonPhrase);
      //   print('Response body: ' + response.body);
      // }
    } on Exception catch (err) {
      print('Excption :' + err.toString());
    }
    returnBack(context, newMember);
  }

  // Future<void> go(BuildContext context, Person newMember) async {
  //   await new Future.delayed(const Duration(seconds: 3));

  //   go1(context, newMember);
  //   setState(() {
  //     _isLoading = false;
  //     //isSignUp = true;
  //     //signedUp = true;
  //   });
  // }

  Future<void> returnBack(BuildContext context, Person newMember) async {
    await new Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context, newMember);
    // (context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    //     (Route<dynamic> route) => false);
    setState(() {
      //isSignUp = false;
    });
  }

  Container inputFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Name',
                style: TextStyle(color: Colors.black),
              ),
              TextFormField(
                autofocus: true,
                //focusNode: _nameFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_nameFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _name = value;
                },
                controller: nameController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle, color: Colors.white70),
                  //Color(THEME.PRIMARY_COLOR)
                  hintText: "Member Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[600])),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

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
