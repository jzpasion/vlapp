import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import '../class/statusclass.dart';
import '../class/ipclass.dart' as globals;
import '../class/tcpconnection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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
  List<String> _videoInfo = [];
  int _index = 0;
  Future<List<String>> _loadNames() async {
    List<String> videoInfo = [];
    await rootBundle.loadString('assets/dataFiles/data.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        videoInfo.add(i);
      }
    });
    return videoInfo;
  }

  Future<File> get _localFile async {
    return File('assets/dataFiles/data.txt');
  }

  Future<File> writeData(String pass) async {
    final file = await _localFile;
    return file.writeAsString(pass);
  }

  test() async {
    String passHolder;
    // List<String> videoInfo = await _loadNames();
    // setState(() {
    //   _videoInfo = videoInfo;
    // });

    // for (var x in _videoInfo) {
    //   print(x);
    // }
    //
    for (int x = 1; x < 11; x++) {
      if (passHolder == null) {
        passHolder = '$x\n';
      } else if (x == 10) {
        passHolder = '$passHolder$x';
      } else {
        passHolder = '$passHolder$x\n';
      }
    }
    writeData(passHolder);
  }

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
                      top: 0,
                    ),
                    child: Text(
                      'Choose a Video',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold, height: 2),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 250,
                  width: 500,
                  child: Center(
                    child: FractionallySizedBox(
                      child: PageView.builder(
                        itemCount: 10,
                        controller: PageController(viewportFraction: 0.7),
                        onPageChanged: (int index) =>
                            setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Card ${i + 1}",
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 550,
                child: Card(
                  color: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 10, 30, 40),
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
                          color: Colors.white,
                          onPressed: test,
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
