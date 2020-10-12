//import 'dart:collection';
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
// import 'dart:ui';
//import 'package:flutter/cupertino.dart';
import 'package:bloodline/bin/models/Person.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as INTL;
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PersonDetailPage extends StatefulWidget {
  Person person;
  PersonDetailPage(person, BuildContext context) {
    this.person = person;
  } 

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailPageState();
  }
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  final _invitePageState = GlobalKey<ScaffoldState>();
  List<Widget> images = new List<Widget>();

  @override
  void initState() {
    super.initState();

    images.add(Image.asset('assets/images/gallery/image1.jpg', height: 35));
    images.add(Image.asset('assets/images/gallery/image2.jpg', height: 35));
    images.add(Image.asset('assets/images/gallery/image3.jpg', height: 35));
    images.add(Image.asset('assets/images/gallery/image4.jpg', height: 35));
    images.add(Image.asset('assets/images/gallery/image5.jpg', height: 35));

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
        length: 5,
        child: Scaffold(
          key: _invitePageState,
          appBar: AppBar(
            backgroundColor: Colors.blue[200],
            title: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    onPressed: () => Navigator.pop(context)),
                Center(
                    child: FlatButton(
                  onPressed: uploadImage(),
                  child: new CachedNetworkImage(
                    imageUrl:
                        '${widget.person.image}', //'${person._links.avatar.href}',
                    height: 60,
                    width: 60,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                )

                    // Text(
                    //   'Detail Page',
                    //   style: TextStyle(color: Colors.white, fontSize: 10),
                    // ),
                    ),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  //iconMargin: EdgeInsets.symmetric(horizontal: 100),
                  icon: Icon(Icons.assignment),
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.accessibility_new),
                  child: Text(
                    'Parents',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.wc),
                  child: Text(
                    'Siblings',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.tag_faces),
                  child: Text(
                    'Children',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.collections),
                  child: Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: listOfWidgets(widget.person)),
        ),
      ),
    );
  }

  List<Widget> listOfWidgets(Person person) {
    print("Person : name : " + person.name);
    List<Widget> widList = List<Widget>();
    widList.add(
      //Column(
      //children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.all(5),
        title: Text(
          '${person.nickName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        //Row(
        //children: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.edit),
        //   onPressed: null,
        // ),
        //  Expanded(
        //child:

        //     Text('${person.nickName}',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),

        //),
        //],
        // ),
        subtitle: Column(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              '${person.name}',
              //style: TextStyle(backgroundColor: Colors.blueAccent[100]),
            ),
            SizedBox(height: 30.0),
            Text(displayDate('${person.dob}')),
            SizedBox(height: 30.0),
            Text('${person.address}'),
            SizedBox(height: 30.0),
            Text('${person.occupation}'),
            SizedBox(height: 30.0),
            Text('${person.company}')
          ],
        ),
      ),
      // RaisedButton(
      //   child: Icon(Icons.delete), //Text('Del'),
      //   color: Colors.transparent,
      //   splashColor: Colors.blue[300],
      //   textColor: Colors.red[200],
      //   padding: EdgeInsets.all(5),
      //   onPressed: () => deleteMember('${person.id}'),
      // )
      //  ],
      //)
    );
    widList.add(Column(
      children: <Widget>[
        ListTile(
          leading: Image.asset('assets/images/gallery/old-man.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Adam'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Father'), //Text('${person.name}'),
        ),
        ListTile(
          leading:
              Image.asset('assets/images/gallery/old-woman.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Eve'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Mother'), //Text('${person.name}'),
        ),
      ],
    ));
    widList.add(Column(
      children: <Widget>[
        ListTile(
          leading: Image.asset('assets/images/gallery/old-man.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Aravind'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Brother'), //Text('${person.name}'),
        ),
        ListTile(
          leading:
              Image.asset('assets/images/gallery/old-woman.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Roshni'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Sister'), //Text('${person.name}'),
        ),
      ],
    ));
    widList.add(Column(
      children: <Widget>[
        ListTile(
          leading: Image.asset('assets/images/gallery/old-man.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Raveendran'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Son'), //Text('${person.name}'),
        ),
        ListTile(
          leading:
              Image.asset('assets/images/gallery/old-woman.jpg', height: 35),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Remya'), //Text('${person.nickName}'),
              ),
            ],
          ),
          subtitle: Text('Daughter'), //Text('${person.name}'),
        ),
      ],
    ));
    widList.add(
      // GridView.builder(
      //   gridDelegate: null,
      //   itemBuilder: (context, index) {
      //     return null;
      //   })
      CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(3.0),
            sliver: SliverGrid.count(
                mainAxisSpacing: 2, //horizontal space
                crossAxisSpacing: 2, //vertical space
                crossAxisCount: 2, //number of images for a row
                children: images),
          ),
        ],
      ),
    );
    return widList;
  }

  String displayDate(String dob) {
    DateTime date = DateTime.parse(dob);
    INTL.DateFormat formatter = INTL.DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  uploadImage() {
    _choose();
    _upload();
  }

  File file;
  void _choose() async {
    // ignore: unnecessary_cast
    file = (await ImagePicker.pickImage(source: ImageSource.camera));
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post("http://10.0.2.2:3000/Person/upload", body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
