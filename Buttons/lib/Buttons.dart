import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  String txt='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
title: Text("Buttons"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: (){
              setState(() {
                txt='TextButton tapped';
              });
            },
            child: Text("Text Button"),
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(15),
                primary: Colors.blue,
                textStyle: TextStyle(fontSize: 18, color: Colors.red)),
          ),


          ElevatedButton(
            onLongPress: null,
            style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                shadowColor: Colors.black,
                elevation: 10,
                textStyle:
                TextStyle(fontSize: 16, color: Colors.black26)),
            onPressed: (){
              setState(() {
                txt='ElevatedButton tapped';
              });
            },
            child: Text(
              "Elevated Button",
            ),
          ),

          OutlinedButton(
              onLongPress: null,
              style: OutlinedButton.styleFrom(primary: Colors.blue),
              onPressed: (){
                setState(() {
                  txt='OutlinedButton tapped';
                });
              },
              child: Text(
                "Ouotlined Button",
                style: TextStyle(
                  fontSize: 18,
                ),
              )),


          FlatButton(
            // splashColor: Colors.red,
            color: Colors.green,
            // textColor: Colors.white,
            child: Text('Flat Button',),
            onPressed: () {
              setState(() {
                txt='FlatButton tapped';
              });
            },
          ),

          Text(txt,textScaleFactor: 2),

          RaisedButton(
            disabledColor: Colors.red,
            disabledTextColor: Colors.black,
            onPressed: (){
              setState(() {
                txt='RaisedButton tapped';
              });
            },
            child: Text('Disabled Button'),
          ),
        ],
      ),
    );
  }
}
