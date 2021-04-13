import 'dart:async';
import 'dart:io';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'statusclass.dart';

Timer timer;
Future<Socket> future;
Socket mySocket;

bool dismiss = false;
bool shown = true;

void changeMonitor(Timer t) {
  t.cancel();
  receive();
}

void receive() {
  Socket.connect('192.168.1.103', 6969).then((Socket sock) {
    connected = true;
    mySocket = sock;
    mySocket.listen(dataHandler);
  }).catchError((e) {
    connected = false;
    Timer.periodic(Duration(seconds: 1), (Timer t) => changeMonitor(t));
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
  notifMessage(data);
}

void notifMessage(mes) {
  // show a notification at top of screen.
  showSimpleNotification(Text(mes.toString()),
      background: Colors.green, position: NotificationPosition.bottom);
}

void connecting() {
  // show a notification at top of screen.
  showSimpleNotification(Text("Connecting to server..."),
      background: Colors.red, position: NotificationPosition.bottom);
}
