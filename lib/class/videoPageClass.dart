library globals;

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

//Retrieve from notepad
// Future<List> _loadNames() async {
//   List<String> _savedNames = [];
//   await rootBundle.loadString('assets/dataFiles/name.txt').then((q) {
//     for (String i in LineSplitter().convert(q)) {
//       _savedNames.add(i);
//     }
//   });
//   return _savedNames;
// }
//
class VideoClass {
  String titleName;
  String dateMod;
  String toDate;
  String fromDate;

  VideoClass({this.titleName, this.dateMod, this.fromDate, this.toDate});
}

List<VideoClass> videoList = [];

Future<File> get _localFileNames async {
  return File('assets/dataFiles/name.txt');
}

Future<File> get _localFileDates async {
  return File('assets/dataFiles/date.txt');
}

Future<File> get _localFileTo async {
  return File('assets/dataFiles/toDate.txt');
}

Future<File> get _localFileFrom async {
  return File('assets/dataFiles/fromDate.txt');
}

Future<File> writeName(String pass) async {
  final file = await _localFileNames;
  return file.writeAsString(pass);
}

Future<File> writeDate(String pass) async {
  final file = await _localFileDates;
  return file.writeAsString(pass);
}

Future<File> writeTo(String pass) async {
  final file = await _localFileTo;
  return file.writeAsString(pass);
}

Future<File> writeFrom(String pass) async {
  final file = await _localFileFrom;
  return file.writeAsString(pass);
}

test() async {
  String passHolder;
  // List<String> videoInfo = await _loadNames();
  // setState(() {
  //   _videoInfo = videoInfo;
  // });

  // for (var x in _videoInfo) {
  //   print(x);
  // }
  //
  for (int x = 1; x < 11; x++) {
    if (passHolder == null) {
      passHolder = '$x\n';
    } else if (x == 10) {
      passHolder = '$passHolder$x';
    } else {
      passHolder = '$passHolder$x\n';
    }
  }
  writeDate(passHolder);
}
