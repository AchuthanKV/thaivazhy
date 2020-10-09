//import 'package:bloodline/PersonDetails/Contact.dart';
import 'package:bloodline/models/DBData.dart';
// import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
//import 'package:bloodline/PersonDetails/Name.dart';
//import 'package:bloodline/PersonDetails/Place.dart';

class Person extends DBData {
  //Name name;
  String name;
  String nickName;
  DateTime dob;
  String gender;
  String occupation;
  String company;
  String address;
  String image;
  List<String> parents;
  //Place place;
  //Contact contact;
  //List<Person> siblings;
  //List<String> images;

  // Person(String s) {
  //   name = Name();
  //   name.firstName = s;
  // }
  Person(
      {ObjectId id,
      String name,
      String nickName,
      String gender,
      String occupation,
      String company,
      String dob,
      String address,
      List<String> parents,
      String image}) {
    this.name = name;
    this.nickName = nickName;
    this.id = id;
    this.gender = gender;
    this.occupation = occupation;
    this.company = company;
    this.dob = (dob != null) ? DateTime.parse(dob) : null;
    this.address = address;
    this.parents = parents;
    this.image = image;
  }

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    //debugPrint('Person: ' + parsedJson.toString());
    // print('id: ' +
    //     ObjectId.fromHexString(parsedJson['_id'].toString()).toString());
    // print('nickName: ' + parsedJson['nickName'].toString());
    //print('date: ' + parsedJson['dob'].toString());
    //print('------------');
    print('parsedJson: ' + parsedJson.toString());
    return Person(
      id: ObjectId.fromHexString(parsedJson['_id'].toString()),
      // id: ObjectId.parse(parsedJson['_id'].toString()),
      name: parsedJson['name'].toString(),
      nickName: parsedJson['nickName'].toString(),
      gender: parsedJson['gender'].toString(),
      occupation: parsedJson['occupation'].toString(),
      company: parsedJson['company'].toString(),
      dob: parsedJson['dob'].toString(),
      address: parsedJson['address'].toString(),
      parents: (parsedJson['parents'] != null)
          ? parsedJson['parents'].cast<String>()
          : List<String>(),
      image: parsedJson['image'].toString(),
    );
  }
}
