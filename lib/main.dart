import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:window_size/window_size.dart';
import './Pages/home.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lumiblinds');
    setWindowMinSize(Size(1280, 720));
    setWindowMaxSize(Size.infinite);
  }
  runApp(OverlaySupport.global(
      child: MaterialApp(
    title: 'Lumiblinds',
    home: Home(),
    theme: ThemeData(fontFamily: 'Monrad'),
    debugShowCheckedModeBanner: false,
  )));
}
