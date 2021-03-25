import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

var _controller = TextEditingController();

FileOpen() {
  final file = OpenFilePicker()
    ..filterSpecification = {'Videos (*.mp4)': '*.mp4', 'All Files': '*.*'}
    ..defaultFilterIndex = 0
    ..defaultExtension = 'doc'
    ..title = 'Select a document';

  final result = file.getFile();
  if (result != null) {
    _controller.text = result.path;
  }
}

drawRect() {
  print('aa');
}

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/green_indicator.png',
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/bar-01.png',
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.only(
                  top: 100,
                ),
                child: Text(
                  'Choose a Video',
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold, height: 2),
                )),
          ),
          Container(
            height: 150,
            width: 550,
            child: Card(
              color: Colors.grey[600],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0)),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                      child: new Theme(
                        data: new ThemeData(primaryColor: Colors.black),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _controller,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "File Location",
                            suffixIcon: IconButton(
                              onPressed: () => FileOpen(),
                              icon: Icon(Icons.folder_open),
                            ),
                          ),
                        ),
                      )),
                  FractionallySizedBox(
                    widthFactor: .8,
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      color: Colors.grey[600],
                      onPressed: drawRect,
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
