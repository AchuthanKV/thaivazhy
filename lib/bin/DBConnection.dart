// ignore: unused_shown_name
// import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

// export './src/people_controller.dart';
// import 'dart:io';
// export 'package:http_server/http_server.dart';

import 'package:mongo_dart/mongo_dart.dart';

class DBConnection {
  static DBConnection _instance;

  final String _host = "localhost";
  final String _port = "27017";
  final String _dbName = "BloodLine";
  Db _db;

  static getInstance() {
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    if (_db == null) {
      try {
        _db = Db(_getConnectionString());
        await _db.open();
      } catch (e) {
        print(e);
      }
    }
    return _db;
  }

  _getConnectionString() {
    print("host : port : dbName :: $_host : $_port : $_dbName");
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db.close();
  }
}
