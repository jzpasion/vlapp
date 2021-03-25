import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'advance.dart';
import '../class/ipclass.dart' as globals;

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
  static List getDummyList() {
    List list = List.generate(maxList, (i) {
      return "${i + 1}";
    });
    return list;
  }

  static List getDrop() {
    List<String> list = List.generate(maxList, (i) {
      return "${i + 1}";
    });
    return list;
  }

  List<globals.IP> iplist = [];

  String selectedIP;
  List items = getDummyList();
  List<String> IPAdd = getDrop();

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
          Scrollbar(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 70.0),
            height: 270.0,
            child: ListView.builder(
                itemCount: items.length,
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
                          Text(items[index],
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
                                value: selectedIP,
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedIP = newVal;
                                  });
                                  iplist.add(globals.IP(
                                      ipHolder: newVal, ipIndex: index));

                                  var checker = iplist.firstWhere(
                                      (element) => element.ipIndex == index);

                                  if (checker == null) {
                                    print("wala");
                                  } else {
                                    print("meron");
                                  }
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
                  print("" +
                      iplist[0].ipIndex.toString() +
                      "," +
                      iplist[0].ipHolder.toString() +
                      "")
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
