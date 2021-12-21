import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String _selectedValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dropdown"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.7,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Select Country",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: SearchField(
                      hint:'Search',
                      searchInputDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Colors.blueGrey.shade200,
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:Colors.blue.withOpacity(0.8),
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),

                      suggestions: [
                        'United States',
                        'India',
                        'Washington',
                        'London',
                        'Africa',
                        'Paris',
                        'China'
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
