import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../class/statusclass.dart';
import '../class/tcpconnection.dart';

class Advance extends StatefulWidget {
  @override
  _AdvanceState createState() => _AdvanceState();
}

class _AdvanceState extends State<Advance> {
  void test_1() {
    Socket.connect('192.168.1.103', 6777).then((Socket sock) {
      print("connected");
      mySocket = sock;
      mySocket.listen(dataHandler);
      mySocket.writeln();

      mySocket.writeln("mark wiliz s del moro");
      print("sent");
    });
  }

  void dataHandler(data) {
    // print(data);
    // var addresses = new String.fromCharCodes(data).trim();
    // var splitAddreses = addresses.split(',');
    // for (int x = 0; x < splitAddreses.length; x++) {
    //   setState(() {
    //     IPAdd.add(splitAddreses[x]);
    //     globals.ipobj.add(globals.IP(ipIndex: x, ipHolder: splitAddreses[x]));
    //   });
    // }
    heatIndicator = int.parse(String.fromCharCode(data[0]));
    lightEnvironmentIndicator = int.parse(String.fromCharCode(data[0]));
    setState(() {
      heatIndicatorHolder = heatIndicator;
      lightEnvironmentIndicatorHolder = lightEnvironmentIndicator;
    });
  }

  int heatIndicatorHolder = heatIndicator;
  int lightEnvironmentIndicatorHolder = lightEnvironmentIndicator;
  double _Brightness = 0;
  bool TestLigtClicked = true;
  int indicator = 1;
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
              heatIndicatorHolder == 1
                  ? 'assets/green_indicator.png'
                  : heatIndicatorHolder == 2
                      ? 'assets/yellow_indicator.png'
                      : heatIndicatorHolder == 3
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
          Center(
            child: Text('Advance Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, height: 2)),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(65, 10, 65, 0),
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Card(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: indicator == 1
                                    ? Colors.red
                                    : indicator == 2
                                        ? Colors.blue
                                        : indicator == 3
                                            ? Colors.yellow
                                            : Colors.red,
                                width: 3.0),
                            borderRadius: BorderRadius.circular(9.0))),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 65, 0),
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Card(
                      elevation: 0.0,
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                                  'Birghtness: ' +
                                      _Brightness.toInt().toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 6))),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Slider(
                                  inactiveColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: _Brightness,
                                  min: 0,
                                  max: 100,
                                  divisions: 100,
                                  label: _Brightness.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      // print(value);
                                      _Brightness = value;
                                      if (value >= 0 && value < 20) {
                                        setState(() {
                                          indicator = 1;
                                        });
                                      } else if (value < 60 && value >= 20) {
                                        setState(() {
                                          indicator = 2;
                                        });
                                      } else if (value < 101 && value >= 60) {
                                        setState(() {
                                          indicator = 3;
                                        });
                                      }
                                    });
                                  })),
                          FractionallySizedBox(
                            widthFactor: .4,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                color: Colors.grey[600],
                                onPressed: () {
                                  if (TestLigtClicked) {
                                    print("on");
                                    setState(() {
                                      TestLigtClicked = !TestLigtClicked;
                                      indicator = 2;
                                    });
                                  } else {
                                    print('off');
                                    setState(() {
                                      TestLigtClicked = !TestLigtClicked;
                                      indicator = 1;
                                    });
                                  }
                                },
                                child: TestLigtClicked
                                    ? Text(
                                        "Test Lights",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    : Text(
                                        "Off",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
