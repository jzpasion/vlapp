import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './video.dart';
import 'configure.dart';
import '../class/statusclass.dart';
import '../class/tcpconnection.dart';
import 'package:badges/badges.dart';
import 'package:overlay_support/overlay_support.dart';
import 'loading.dart' as load;

Timer timer;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int heatIndicatorHolder = heatIndicator;
  int lightEnvironmentIndicatorHolder = lightEnvironmentIndicator;
  bool connectServer = connected;
  bool runOnce = true;
  void notifMessage() {
    // show a notification at top of screen.
    showSimpleNotification(Text("Configure is not set!"),
        background: Colors.red);
  }

  void changeMonitor(Timer t) {
    setState(() {
      connectServer = connected;
      if (connectServer) {
        t.cancel();
      }
      checkStatus();
    });
  }

  void checkStatus() {
    if (connectServer) {
      load.DialogBuilder(context).hideOpenDialog();
    } else {
      if (runOnce) {
        runOnce = false;
        receive();
        load.DialogBuilder(context)
            .showLoadingIndicator('Connecting to server...');
        Timer.periodic(Duration(seconds: 1), (Timer t) => changeMonitor(t));
      }
    }
  }

  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => checkStatus());
  // }

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
            tooltip: 'Heat Sensor Indicator',
            icon: Image.asset(
              heatIndicator == 1
                  ? 'assets/green_indicator.png'
                  : heatIndicator == 2
                      ? 'assets/yellow_indicator.png'
                      : heatIndicator == 3
                          ? 'assets/red_indicator.png'
                          : () => print("error"),
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          ),
          IconButton(
            tooltip: 'Light Sensor Indicator',
            icon: Image.asset(
              lightEnvironmentIndicatorHolder == 1
                  ? 'assets/bar-01.png'
                  : lightEnvironmentIndicatorHolder == 2
                      ? 'assets/bar-02.png'
                      : lightEnvironmentIndicatorHolder == 3
                          ? 'assets/bar-03.png'
                          : lightEnvironmentIndicatorHolder == 4
                              ? 'assets/bar-04.png'
                              : lightEnvironmentIndicatorHolder == 5
                                  ? 'assets/bar-05.png'
                                  : () => print("Error"),
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
          Image.asset(
            'assets/lumilogo.png',
            fit: BoxFit.cover,
            height: 200,
          ),
          // Text(
          //   'Lumiblinds',
          //   textAlign: TextAlign.center,
          //   style:
          //       TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 2),
          // ),
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
                          size: 300,
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
                          onPressed: () async {
                            var navigationResult = await Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Configure()));
                            if (navigationResult == "1") {
                              setState(() {
                                heatIndicatorHolder = heatIndicator;
                                lightEnvironmentIndicatorHolder =
                                    lightEnvironmentIndicator;
                              });
                            }
                          },
                          child: Text(
                            "Configure",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                            size: 300, color: Colors.black),
                      )),
                      FractionallySizedBox(
                        widthFactor: .4,
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          color: Colors.grey[600],
                          onPressed: () async {
                            var navigationResult = await Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => VideoPage()));
                            if (navigationResult == "1") {
                              setState(() {
                                heatIndicatorHolder = heatIndicator;
                                lightEnvironmentIndicatorHolder =
                                    lightEnvironmentIndicator;
                              });
                            }
                          },
                          child: Text(
                            "Choose a Video",
                            style: TextStyle(
                                fontSize: 20,
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

//Loading Screen
//