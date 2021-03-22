import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter_dropzone_platform_interface/flutter_dropzone_platform_interface.dart';

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

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        elevation: 0.0,
      ),
      backgroundColor: Colors.blueGrey[600],
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
                      fontSize: 40, fontWeight: FontWeight.bold, height: 3),
                )),
          ),
          Container(
            height: 150,
            width: 550,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                    child: TextField(
                      controller: _controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        focusColor: Colors.transparent,
                        hintText: "File Location",
                        suffixIcon: IconButton(
                          onPressed: () => FileOpen(),
                          icon: Icon(Icons.folder_open),
                        ),
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: .8,
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      color: Colors.orange[50],
                      onPressed: drawRect,
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
