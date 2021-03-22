import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

ScrollController _scrollController = ScrollController();
drawRect() {
  print('aa');
}

class Configure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        elevation: 0.0,
      ),
      backgroundColor: Colors.blueGrey[600],
      body: Column(
        children: <Widget>[
          Center(
            child: Text('Panel Arrangement',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, height: 3)),
          ),
          Scrollbar(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 160.0,
                  color: Colors.red,
                ),
                Container(
                  width: 160.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 160.0,
                  color: Colors.green,
                ),
                Container(
                  width: 160.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: FractionallySizedBox(
              widthFactor: .8,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                color: Colors.orange[50],
                onPressed: drawRect,
                child: Text(
                  "Show Panel Arrangement",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
