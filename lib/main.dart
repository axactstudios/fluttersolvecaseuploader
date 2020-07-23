import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:fluttersolvecaseuploader/constants.dart';
import 'package:fluttersolvecaseuploader/UploadSolution.dart';
import 'package:fluttersolvecaseuploader/UploadStudyMaterial.dart';
import 'package:fluttersolvecaseuploader/UploadVideo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLVECASE',
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  String task = 'Upload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: kPrimaryColor,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  if (_selectedIndex == 0) task = 'Upload New Video';
                  if (_selectedIndex == 1) task = 'Upload New Solution';
                  if (_selectedIndex == 2) task = 'Upload Material';
                });
              },
              labelType: NavigationRailLabelType.selected,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 40,
                  ),
                  selectedIcon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: Text(
                    'Video',
                    style: TextStyle(fontFamily: 'Cabin', color: Colors.white),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 40,
                  ),
                  selectedIcon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: Text(
                    'Solution',
                    style: TextStyle(fontFamily: 'Cabin', color: Colors.white),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 40,
                  ),
                  selectedIcon: Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: Text(
                    'Study Material',
                    style: TextStyle(fontFamily: 'Cabin', color: Colors.white),
                  ),
                ),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("SOLVECASE",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Cabin',
                          color: kPrimaryColor,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      task,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 28,
                        fontFamily: 'Cabin',
                        color: kPrimaryColor,
                      ),
                    ),
                    if (_selectedIndex == 0)
                      UploadVideo()
                    else if (_selectedIndex == 1)
                      UploadSolution()
                    else if (_selectedIndex == 2)
                      UploadStudyMaterial()
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
