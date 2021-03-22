import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './video.dart';
import 'configure.dart';

drawRect() {}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      body: Column(
        children: <Widget>[
          Text(
            'Vertical Lights',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 3),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(60, 20, 60, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Container(
                          child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.settings_rounded,
                          size: 400,
                          color: Colors.pink[300],
                        ),
                      )),
                      FractionallySizedBox(
                        widthFactor: .4,
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          color: Colors.orange[50],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Configure()));
                          },
                          child: Text(
                            "Configure",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Container(
                          child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(Icons.video_call_rounded,
                            size: 400, color: Colors.pink[300]),
                      )),
                      FractionallySizedBox(
                        widthFactor: .4,
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          color: Colors.orange[50],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPage()));
                          },
                          child: Text(
                            "Choose a Video",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
