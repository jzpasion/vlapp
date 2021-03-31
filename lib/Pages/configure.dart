import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'advance.dart';
import '../class/ipclass.dart' as globals;

//TCP connection
Future<Socket> future;
Socket mySocket;

ScrollController _scrollController = ScrollController();
drawRect() {
  print('aa');
}

class Configure extends StatefulWidget {
  @override
  _ConfigureState createState() => _ConfigureState();
}

int maxList = 69;

class _ConfigureState extends State<Configure> {
  // static List getDummyList() {
  //   List list = List.generate(maxList, (i) {
  //     return "${i + 1}";
  //   });
  //   return list;
  // }

  // static List getDrop() {
  //   List<String> list = List.generate(maxList, (i) {
  //     return "${i + 1}";
  //   });
  //   return list;
  // }

  String selectedIP;
  List<String> IPAdd = [];

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
    var addresses = new String.fromCharCodes(data).trim();
    var splitAddreses = addresses.split(',');
    for (int x = 0; x < splitAddreses.length; x++) {
      setState(() {
        IPAdd.add(splitAddreses[x]);
        globals.ipobj.add(globals.IP(ipIndex: x, ipHolder: splitAddreses[x]));
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => test_1());
  }
  // addIPIndex() {
  //   for (var i = 0; i < getDummyList().length - 1; i++) {
  //     iplist.add(globals.IP(ipIndex: i, ipHolder: IPAdd[i]));
  //   }
  // }

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
            child: Text('Panel Arrangement',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, height: 2)),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 70.0),
              height: 69.0,
              alignment: Alignment.centerRight,
              child: Container(
                height: 50,
                width: 150,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  color: Colors.grey[600],
                  onPressed: () => test_1(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Retrieve IP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.autorenew_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Scrollbar(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 70.0),
            height: 270.0,
            child: ListView.builder(
                itemCount: IPAdd.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 190,
                    child: Card(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Column(
                        children: <Widget>[
                          Text((globals.ipobj[index].ipIndex + 1).toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                  height: 2)),
                          Container(
                            width: 300.0,
                            child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                hint: Text("Select IP Address"),
                                value: globals.ipobj[index].ipHolder,
                                onChanged: (newVal) {
                                  setState(() {
                                    var checker = globals.ipobj.firstWhere(
                                        (element) =>
                                            element.ipHolder == newVal);

                                    checker.ipHolder =
                                        globals.ipobj[index].ipHolder;
                                    for (var i in globals.ipobj) {
                                      if (i.ipIndex == index) {
                                        i.ipHolder = newVal;
                                      }
                                    }
                                  });

                                  // if (iplist.isNotEmpty) {
                                  //   var checker = iplist.firstWhere(
                                  //       (element) => element.ipIndex == index,
                                  //       orElse: () => null);
                                  //   print(checker);
                                  //   if (checker == null) {
                                  //     iplist.add(globals.IP(
                                  //         ipHolder: newVal, ipIndex: index));
                                  //   } else {
                                  //     print(checker.ipHolder +
                                  //         "," +
                                  //         checker.ipIndex.toString());
                                  //   }
                                  // } else {
                                  //   iplist.add(globals.IP(
                                  //       ipHolder: newVal, ipIndex: index));
                                  // }
                                },
                                items: IPAdd.map(
                                  (val) {
                                    return DropdownMenuItem(
                                        child: new Text(val), value: val);
                                  },
                                ).toList(),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: FractionallySizedBox(
              widthFactor: .5,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                color: Colors.grey[600],
                onPressed: () => {
                  print(IPAdd.length)
                  // print("" +
                  //     iplist[0].ipIndex.toString() +
                  //     "," +
                  //     iplist[0].ipHolder.toString() +
                  //     "")
                },
                child: Text(
                  "Show Panel Arrangement",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Divider(),
                ),
                new InkWell(
                  focusColor: Colors.red,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Advance()));
                  },
                  child: new Text("Advance Settings",
                      style: TextStyle(fontSize: 15)),
                ),
                Expanded(
                  child: Divider(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
