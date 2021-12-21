import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
import 'LoginScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _storeLoggedInStatus(true);
      }),
      body: Center(
        child: RaisedButton(onPressed: () async {
          bool isLoggedIn = await _getLoggedInStatus();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return isLoggedIn ? HomeScreen() : LoginScreen();
          }));
        }),
      ),
    );
  }
  // Sets the login status
  void _storeLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLoggedIn', isLoggedIn);
  }

  // Gets the logged in status
  Future<bool> _getLoggedInStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('isLoggedIn') ?? false;
  }
}

