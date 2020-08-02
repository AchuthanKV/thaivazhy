//import 'package:bloodline/PersonDetails/Contact.dart';
import 'package:bloodline/PersonDetails/DBData.dart';
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
      String image}) {
    this.name = name;
    this.nickName = nickName;
    this.id = id;
    this.gender = gender;
    this.occupation = occupation;
    this.company = company;
    this.dob = (dob != null) ? DateTime.parse(dob) : null;
    this.address = address;
    this.image = image;
  }

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    print('Person: ' + parsedJson.toString());
    // print('id: ' +
    //     ObjectId.fromHexString(parsedJson['_id'].toString()).toString());
    // print('nickName: ' + parsedJson['nickName'].toString());
    print('date: ' + parsedJson['dob'].toString());
    print('------------');
    return Person(
      id: ObjectId.fromHexString(parsedJson['_id'].toString()),
      name: parsedJson['name'].toString(),
      nickName: parsedJson['nickName'].toString(),
      gender: parsedJson['gender'].toString(),
      occupation: parsedJson['occupation'].toString(),
      company: parsedJson['company'].toString(),
      dob: parsedJson['dob'].toString(),
      address: parsedJson['address'].toString(),
      image: parsedJson['image'].toString(),
    );
  }
}
