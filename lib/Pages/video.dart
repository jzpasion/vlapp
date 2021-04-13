import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import '../class/statusclass.dart';
import '../class/ipclass.dart' as globals;
import '../class/tcpconnection.dart';

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
  int lightEnvironmentIndicatorHolder = lightEnvironmentIndicator;
  int heatIndicatorHolder = heatIndicator;
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

  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => test_1());
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _popNavigationResult(context, "1");
          return false;
        },
        child: Scaffold(
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
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
                          color: Colors.black,
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
        ));
  }

  void _popNavigationResult(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }
}
