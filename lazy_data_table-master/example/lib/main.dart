import 'package:flutter/material.dart';

import 'headerless_table.dart';
import 'simple_table.dart';
import 'custom_size_table.dart';
import 'themed_table.dart';
import 'four_headers_table.dart';

void main() {
  runApp(MaterialApp(
    title: 'Example',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Examples")),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("Simple table"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimpleTable())),
            ),
            ElevatedButton(
              child: Text("Header-less table"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HeaderlessTable())),
            ),
            ElevatedButton(
              child: Text("Custom column and row sizes table"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomSizeTable())),
            ),
            ElevatedButton(
              child: Text("Themed table"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThemedTable())),
            ),
            ElevatedButton(
              child: Text("Four headers table"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FourHeadersTable())),
            ),
          ],
        ),
      ),
    );
  }
}
