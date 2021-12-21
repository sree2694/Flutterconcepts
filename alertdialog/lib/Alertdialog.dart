import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alertdialog extends StatefulWidget {
  const Alertdialog({Key? key}) : super(key: key);

  @override
  _AlertdialogState createState() => _AlertdialogState();
}

class _AlertdialogState extends State<Alertdialog> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
