import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:window_size/window_size.dart';
import './Pages/home.dart';
import './Pages/video.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('App title');
    setWindowMinSize(const Size(1600, 900));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MaterialApp(title: 'Vertical Lights', home: Home()));
}
