import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:verticalligthtsapp/class/videoPageClass.dart';
import '../class/statusclass.dart';
import '../class/ipclass.dart' as globals;
import '../class/tcpconnection.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'loading.dart' as load;

var _controller = TextEditingController();
var _titleController = TextEditingController();
var cancelStatus = false;

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

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int _index = 0;
  List<VideoClass> videoHolderList = [];
  String enterTitle;
  List<String> _savedNames = [];
  List<String> _savedDates = [];
  List<String> _savedFrom = [];
  List<String> _savedTo = [];

  int lightEnvironmentIndicatorHolder = lightEnvironmentIndicator;
  int heatIndicatorHolder = heatIndicator;

//Retrieve from notepad
  loadFiles() async {
    videoList.removeRange(0, videoList.length);
    await rootBundle.loadString('assets/dataFiles/name.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        _savedNames.add(i);
      }
    });
    await rootBundle.loadString('assets/dataFiles/date.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        _savedDates.add(i);
      }
    });
    await rootBundle.loadString('assets/dataFiles/toDate.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        _savedTo.add(i);
      }
    });
    await rootBundle.loadString('assets/dataFiles/fromDate.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        _savedFrom.add(i);
      }
    });
    //print(_savedNames.length);
    for (int x = 0; x < _savedNames.length; x++) {
      videoList.add(VideoClass(
          titleName: _savedNames[x],
          dateMod: _savedDates[x],
          fromDate: _savedFrom[x],
          toDate: _savedTo[x]));
    }
    setState(() {
      videoHolderList = videoList;
    });
  }

  showDialogPopup(int pos) async {
    var resut = await showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                backgroundColor: Colors.white,
                content: PopUp(text: "text")));
      },
    );
    print(resut);

    // load.DialogBuilder(context).showLoadingIndicator(
    //     'Are you sure you want to delete ' +
    //         videoHolderList[pos].titleName +
    //         '?',
    //     1);
  }

  deleteVideo(int pos) {
    String nameHolder;
    String dateHolder;
    String toHolder;
    String fromHolder;
    setState(() {
      videoHolderList.removeAt(pos);
      for (int x = 0; x < videoHolderList.length; x++) {
        if (x == 0) {
          nameHolder = videoHolderList[x].titleName;
          dateHolder = videoHolderList[x].dateMod;
          toHolder = videoHolderList[x].toDate;
          fromHolder = videoHolderList[x].fromDate;
        } else if (x == videoHolderList.length - 1) {
          nameHolder = '$nameHolder' + videoHolderList[x].titleName;
          dateHolder = '$dateHolder' + videoHolderList[x].dateMod;
          toHolder = '$toHolder' + videoHolderList[x].toDate;
          fromHolder = '$fromHolder' + videoHolderList[x].fromDate;
        } else {
          nameHolder = '$nameHolder' + videoHolderList[x].titleName + '\n';
          dateHolder = '$dateHolder' + videoHolderList[x].dateMod + '\n';
          toHolder = '$toHolder' + videoHolderList[x].toDate + '\n';
          fromHolder = '$fromHolder' + videoHolderList[x].fromDate + '\n';
        }
      }
      writeName(nameHolder);
      writeDate(dateHolder);
      writeTo(toHolder);
      writeFrom(fromHolder);
    });
  }

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

  printTest() {
    String nameHolder;
    String dateHolder;
    String toHolder;
    String fromHolder;

    if (_titleController.text.isEmpty) {
      notifMessageRed("Please Enter a Title!");
      print(videoList.length);
    } else {
      setState(() {
        videoHolderList.add(VideoClass(
            titleName: _titleController.text,
            dateMod: '' +
                DateTime.now().month.toString() +
                '/' +
                DateTime.now().day.toString() +
                '/' +
                DateTime.now().year.toString(),
            fromDate: "Not Set",
            toDate: "Not Set"));
      });
      for (int x = 0; x < videoHolderList.length; x++) {
        if (x == 0) {
          nameHolder = videoHolderList[x].titleName;
          dateHolder = videoHolderList[x].dateMod;
          toHolder = videoHolderList[x].toDate;
          fromHolder = videoHolderList[x].fromDate;
        } else if (x == videoHolderList.length - 1) {
          nameHolder = '$nameHolder' + videoHolderList[x].titleName;
          dateHolder = '$dateHolder' + videoHolderList[x].dateMod;
          toHolder = '$toHolder' + videoHolderList[x].toDate;
          fromHolder = '$fromHolder' + videoHolderList[x].fromDate;
        } else {
          nameHolder = '$nameHolder' + videoHolderList[x].titleName + '\n';
          dateHolder = '$dateHolder' + videoHolderList[x].dateMod + '\n';
          toHolder = '$toHolder' + videoHolderList[x].toDate + '\n';
          fromHolder = '$fromHolder' + videoHolderList[x].fromDate + '\n';
        }
      }
      writeName(nameHolder);
      writeDate(dateHolder);
      writeTo(toHolder);
      writeFrom(fromHolder);
    }
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

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadFiles());
  }

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
                      child: videoHolderList.length == 0
                          ? Container(
                              child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                Icons.settings_rounded,
                                size: 300,
                                color: Colors.black,
                              ),
                            ))
                          : PageView.builder(
                              itemCount: videoHolderList.length,
                              controller: PageController(viewportFraction: 0.7),
                              onPageChanged: (int index) =>
                                  setState(() => _index = index),
                              itemBuilder: (_, i) {
                                return Transform.scale(
                                  scale: i == _index ? 1 : 0.9,
                                  child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            leading: IconButton(
                                                splashRadius: 30,
                                                iconSize: 30,
                                                color: Colors.black,
                                                icon: Icon(Icons
                                                    .play_circle_fill_rounded),
                                                onPressed: () => {}),
                                            title: Text(
                                                videoHolderList[i].titleName),
                                            subtitle: Text(
                                              videoHolderList[i].dateMod,
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            child: FractionallySizedBox(
                                              widthFactor: 0.5,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.0),
                                                ),
                                                color: Colors.grey[600],
                                                onPressed: () {
                                                  showSimpleNotification(
                                                      Text("Set Time From"),
                                                      background: Colors.green,
                                                      position:
                                                          NotificationPosition
                                                              .bottom);
                                                  DatePicker.showTimePicker(
                                                    context,
                                                    showSecondsColumn: false,
                                                    currentTime: DateTime.now(),
                                                    onConfirm: (time) {
                                                      showSimpleNotification(
                                                          Text("Set Time To"),
                                                          background:
                                                              Colors.green,
                                                          position:
                                                              NotificationPosition
                                                                  .bottom);
                                                      DatePicker.showTimePicker(
                                                        context,
                                                        showSecondsColumn:
                                                            false,
                                                        currentTime:
                                                            DateTime.now(),
                                                        onConfirm: (time) {
                                                          print(time.hour);
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  "Set Time",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30, 5, 30, 5),
                                              child: Text(
                                                'From: ' +
                                                    videoHolderList[i].fromDate,
                                                style: TextStyle(fontSize: 15),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 5),
                                              child: Text(
                                                  'To:       ' +
                                                      videoHolderList[i].toDate,
                                                  style:
                                                      TextStyle(fontSize: 15))),
                                          ButtonBar(
                                            alignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  tooltip: 'Upload new video',
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  splashRadius: 30,
                                                  iconSize: 30,
                                                  color: Colors.black,
                                                  icon: Icon(
                                                      Icons.upload_rounded),
                                                  onPressed: () => {}),
                                              IconButton(
                                                  tooltip: 'Delete',
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  splashRadius: 30,
                                                  iconSize: 30,
                                                  color: Colors.red,
                                                  icon: Icon(
                                                      Icons.delete_rounded),
                                                  onPressed: () =>
                                                      showDialogPopup(i)),
                                            ],
                                          )
                                        ],
                                      )),
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
                              EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
                          child: new Theme(
                            data: new ThemeData(primaryColor: Colors.black),
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 15),
                        child: new Theme(
                            data: new ThemeData(primaryColor: Colors.black),
                            child: TextField(
                              controller: _titleController,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration:
                                  InputDecoration(hintText: 'Enter File Name'),
                            )),
                      ),
                      ButtonTheme(
                          height: 50,
                          child: SizedBox(
                            width: 300,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              color: Colors.white,
                              onPressed: printTest,
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ))
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

class PopUp extends StatelessWidget {
  PopUp({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return WillPopScope(
      onWillPop: () async {
        _popNavigationResult(context, "1");
        return false;
      },
      child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [_getText(displayedText), _getButtons(context)])),
    );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }

  Padding _getButtons(context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Text(
              'No',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            color: Colors.transparent,
            onPressed: () {
              _popNavigationResult(context, "0");
            },
          ),
          FlatButton(
            child: Text('Yes', style: TextStyle(color: Colors.black)),
            color: Colors.transparent,
            onPressed: () {
              _popNavigationResult(context, "1");
            },
          ),
        ],
      ),
    );
  }

  void _popNavigationResult(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }
}
