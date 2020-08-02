//import 'dart:html';
//import 'dart:convert';
import 'dart:io';

//import 'package:bloodline/bin/DBConnection.dart';
import 'package:bloodline/PersonDetails/NewPersonPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as INTL;
import 'package:mongo_dart/mongo_dart.dart' as MONGO;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'PersonDetails/Person.dart';
import 'PersonDetails/PersonDetailsPage.dart';

void main() {
  runApp(BloodLine());
}

class BloodLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter: BloodLine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BloodLine'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDBConnected = false;
  MONGO.Db dbCon = new MONGO.Db("mongodb://localhost:27017/BloodLine");
  MONGO.Db db;
  Person person = Person(); //"AKV");
  List<Person> persons = List<Person>();

  @override
  void initState() {
    super.initState();
    try {
      //initDB();
      //DBConnection dbCon = DBConnection();
      //mongo.Db dbdb = dbCon.getConnection() as mongo.Db;
      //if (dbdb != null) {
      //  print(dbdb);
      //}

      // get Person Data
      this.getPersonData();

      person = Person(); //"AKV");
      person.name = 'Alex Drake';
      person.nickName = 'alex';
      person.dob = DateTime.parse("19900301");
      person.address = 'Kerala';
      person.occupation = 'Software Engineer';
      person.company = 'vmware';
      person.image =
          'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png?1592828498'; //'https://avatarfiles.alphacoders.com/160/160703.jpg';
      persons.add(person);

      person = Person(); //"AKV");
      person.name = 'Drake Bloend';
      person.nickName = 'drake';
      person.dob = DateTime.parse("19900101");
      person.address = 'Punjab';
      person.occupation = 'Tech Engineer';
      person.company = 'vmware';
      person.image =
          'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png?1592828498';
      //'https://image.freepik.com/free-vector/businessman-character-avatar-icon-vector-illustration-design_24877-18271.jpg';
      persons.add(person);

      person = Person(); //"AKV");
      person.name = 'Blake Rakel';
      person.nickName = 'blake';
      person.dob = DateTime.parse("19900201");
      person.address = 'Singapore';
      person.occupation = 'Syatem Engineer';
      person.company = 'Oracle';
      person.image =
          'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png?1592828498';
      //'https://images-platform.99static.com/jQu2xohritutSVmnVq7np7rbkxg=/0x0:1920x1920/500x500/top/smart/99designs-contests-attachments/106/106359/attachment_106359975';

      persons.add(person);
    } on SocketException catch (e) {
      print('initDB Exception : ' + e.toString());
    }
  }

  Future<void> initDB() async {
    final MONGO.Db dbConn = new MONGO.Db("mongodb://localhost:27017/BloodLine");
    // 'mongo "mongodb+srv://infinitezero.edpzp.mongodb.net/BloodLine" --username UserZero');
    //mongo "mongodb+srv://infinitezero.edpzp.mongodb.net/<dbname>" --username UserZero
    MONGO.Db tempDB = MONGO.Db('');
    if (dbConn != null) {
      try {
        tempDB = await dbConn.open();
      } on SocketException catch (e) {
        print("dbConn.open Exception : " + e.toString());
      }

      // ignore: unused_element
      setState() {
        isDBConnected = true;
        db = tempDB;
      }
    }
    if (person == null) {
      person = Person(); //"AKV");
    }
  }

  Future<void> getOnePerson(colName) async {
    print("In getOnePerson...");
    if (isDBConnected) {
      var coll = db.collection(colName);
      var list = await coll.find().toList();
      print("Person List >>>>>> ");
      print(list);
      //person.name = ;
    }
  }

  dbCall(String colName) async {
    //var db;
    var coll = db.collection(colName);
    await coll.find(MONGO.where.lt("age", 18)).toList();

    //....

    await coll
        .find(MONGO.where.gt("my_field", 995).sortBy('my_field'))
        .forEach((v) => print(v));

    //....

    await coll.find(MONGO.where.sortBy('itemId').skip(300).limit(25)).toList();

    var usersCollection;
    await usersCollection.insertAll([
      {'login': 'jdoe', 'name': 'John Doe', 'email': 'john@doe.com'},
      {'login': 'lsmith', 'name': 'Lucy Smith', 'email': 'lucy@smith.com'}
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //initDB();
    //person = Person(); //"AKV");
    //getOnePerson("BloodLine");
    //getPersonData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: popltDataWid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPersonPage()))
        },
        tooltip: 'Add Member',
        child: Icon(Icons.add),
      ),

      // Center(
      //   child: ,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Future<void> getPersonData() async {
    print('getPersonData');
    // var client = http.Client();
    // try {
    //   var uriResponse = await client.post('https://example.com/whatsit/create',
    //       body: {'name': 'doodle', 'color': 'blue'});
    //   print(await client.get(uriResponse.bodyFields['uri']));
    // } finally {
    //   client.close();
    // }

    //var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    var url = 'http://192.168.1.6:3000/Person';
    //var url =
    //    'https://gorest.co.in/public-api/users?_format=json&access-token=tGDF1qweHEnDtFr5chss1qIhsWimgorPVuvE';
    /*
                        {
                            "id": "11901",
                            "first_name": "Raquel",
                            "last_name": "Wisozk",
                            "gender": "female",
                            "dob": "1951-09-10",
                            "email": "mcorkery@example.com",
                            "phone": "1-453-447-6580",
                            "website": "http://www.welch.info/qui-voluptatem-rerum-natus-beatae-id-repudiandae",
                            "address": "118 Patricia Neck Apt. 015\nNorth Retastad, CA 64776",
                            "status": "active",
                            "_links": {
                                "self": {
                                    "href": "https://gorest.co.in/public-api/users/11901"
                                },
                                "edit": {
                                    "href": "https://gorest.co.in/public-api/users/11901"
                                },
                                "avatar": {
                                    "href": "https://lorempixel.com/250/250/people/?23624"
                                }
                            }
                        }
                      */

    /* var res = await http.post("https://voyagermobile.flysaa.com/saamobile/SendSMS",
                        headers: {"Content-Type": "application/json",},
                        body:("{"+"numbers"+":"+"[$number]"+"}"));
                */
    //Person s = Person();

    getResponse(url);

    print('Persons:=>>====' + persons.toString());

    // var res = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    //   body: json.encode(data) );
    // print('response' + convert.jsonDecode(res.body));
  }

  Object getResponse(url) async {
    Object resp;
    print('URL: ---- ' + url);
    http.Response response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //resp = await convert.jsonDecode(response.body);
        print('RESPONSE :---------------');
        print(resp);
        final List parsedList = await convert.jsonDecode(response.body);
        List<Person> list =
            parsedList.map((val) => Person.fromJson(val)).toList();
        setState(() {
          persons = list;
        });
      }
      // else {
      //   print('Response reason: ' + response.reasonPhrase);
      //   print('Response body: ' + response.body);
      // }
    } on Exception catch (err) {
      print('Excption :' + err.toString());
    }
    return resp;
  }

  Widget popltDataWid() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return popltDataItem(persons[index]);
        });
  }

  //decoration: BoxDecoration(color: Colors.green[300]),

  Widget popltDataItem(person) => Container(
        decoration: BoxDecoration(color: Colors.blue[200]),
        margin: const EdgeInsets.all(5.0),
        child: FlatButton(
          onPressed: () {
            //removeSharedPreferenceKeys();
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => DetailPage()),
            //     (Route<dynamic> route) => false);
            //-----------
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => PersonDetailPage(person, context)));
          },
          child: Column(
            children: <Widget>[
              new CachedNetworkImage(
                imageUrl: '${person.image}', //'${person._links.avatar.href}',
                height: 50,
                width: 50,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
              ListTile(
                title: Text('${person.nickName}'),
                subtitle: Column(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text('${person.name}'),
                    Text(displayDate('${person.dob}')),
                    Text('${person.address}'),
                    Text('${person.occupation}'),
                    Text('${person.company}')
                  ],
                ),
              ),

              // ListTile(
              //   title: Text('${person.name}'),
              //   subtitle: Text('${person.nickName}'),
              //   //contentPadding: ,
              // ),
            ],
          ),
        ),
      );

  String displayDate(String dob) {
    DateTime date = DateTime.parse(dob);
    INTL.DateFormat formatter = INTL.DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  addPerson() {}

  //{
  //return

  // ListTile(
  //   title: Text('NAME'),
  //   subtitle: Text('nickName'),
  //   //contentPadding: ,
  // );
  //}

  /*
  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row( 
              children: <Widget>[
                Center(
                    child: Text(
                  'Name: ',
                )),
                Center(
                    child: Text(
                  '${person.name}',
                  style: Theme.of(context).textTheme.headline6,
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Nick Name:',
                ),
                Text(
                  '${person.nickName}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'DOB:',
                ),
                Text(
                  '${person.dob}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Gender:',
                ),
                Text(
                  '${person.gender}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
  */
}
