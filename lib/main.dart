import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:window_size/window_size.dart';
import './Pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('App title');
    setWindowMinSize(Size(1280, 720));
    setWindowMaxSize(Size(1280, 720));
  }
  runApp(MaterialApp(
    title: 'Vertical Lights',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
