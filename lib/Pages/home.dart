import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './video.dart';
import 'configure.dart';

drawRect() {}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // This widget is the root of your application.
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
          Text(
            'Vertical Lights',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 2),
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
                          color: Colors.black,
                        ),
                      )),
                      FractionallySizedBox(
                        widthFactor: .4,
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          color: Colors.grey[600],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Configure()));
                          },
                          child: Text(
                            "Configure",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                            size: 400, color: Colors.black),
                      )),
                      FractionallySizedBox(
                        widthFactor: .4,
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          color: Colors.grey[600],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPage()));
                          },
                          child: Text(
                            "Choose a Video",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
