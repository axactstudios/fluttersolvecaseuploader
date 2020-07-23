import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersolvecaseuploader/constants.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';

class UploadVideo extends StatefulWidget {
  UploadVideo({Key key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final _formKey = GlobalKey<FormState>();
  final listOfCategories1 = [
    "Sem1",
    "Sem2",
    "Sem3",
  ];
  final College = ['JIIT', 'JIIT-128'];
  final listOfSubjects1Cse = [
    'Mathematics-1',
    'Physics-1 ',
    'SDF-1',
    'English',
    'Physics Lab-1 ',
    'SDF LAB -1',
    'EDD'
  ];
  final listOfSubjects2Cse = [
    "Mathematics-2",
    "Physics-2",
    "Electrical Science-I",
    "SDF-2",
    "Physics Lab-2",
    "Electrical Science Lab-I",
    "SDF LAB-2",
    "Workshop"
  ];
  final listOfSubjects3Cse = [
    "Database Systems and Web",
    "Data Structures",
    "Data Structures Lab",
    "Database Systems and Web Lab",
    "Electrical Science-II",
    "Electrical Science Lab-II ",
    "Theoretical Foundations of Computer Science",
    "Economics"
  ];

  final listOfSubjects3Ece = [
    "Probability and Random Processes",
    "Signals & Systems",
    "Analogue Electronics",
    "Environmental Science",
    "Signals & Systems Lab",
    "Analogue Electronics Lab",
    "Electrical Science-II ",
    "Electrical Science Lab-II",
    "Economics"
  ];
  final listOfSubjects1Bt = [
    "Basic Mathematics-1",
    "Physics for Biotechnology",
    "FOCP-1",
    "English",
    "Physics Lab-1",
    "Computer Programming Lab-I",
    "Workshop"
  ];
  final listOfSubjects2Bt = [
    "Basic Mathematics-2",
    "Biophysical Techniques",
    "Electrical Science-I",
    "FOCP-2",
    "Basic Bioscience Lab",
    "Electrical Science Lab-I",
    "Computer Programming Lab-II",
    "EDD"
  ];
  final listOfSubjects3Bt = [
    "Probability and Statistics",
    "Biochemistry",
    "Thermodynamics and Chemical Processes ",
    "Environmental Science",
    "Biochemical Techniques Lab",
    "Thermodynamics and Chemical Processes Lab",
    "Electrical Science-II",
    "Electrical Science Lab-II",
    "Economics"
  ];
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  final Branches = ['CSE', 'ECE', 'BT'];
  String dropdownValue1 = 'Sem1';
  String dropdownValue3 = 'JIIT';
  final urlController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final quantity = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference();
  String dropdownValue2 = 'CSE';
  List<String> temp = [
    'Mathematics-1',
    'Physics-1 ',
    'SDF-1',
    'English',
    'Physics Lab-1 ',
    'SDF LAB -1',
    'EDD'
  ];
  String DropdownValuesub = 'Mathematics-1';








  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Enter Video Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Video Name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: "Enter Video URL",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Video URL';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: DropdownButtonFormField(
                value: dropdownValue3,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Select College',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: College.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue3 = newValue;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select College';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: DropdownButtonFormField(
                value: dropdownValue1,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Select Semester',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: listOfCategories1.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue1 = newValue;
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects1Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects2Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects3Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects3Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects3Bt;
                      DropdownValuesub = temp[0];
                    }
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Semester';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: DropdownButtonFormField(
                value: dropdownValue2,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Select Branch',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: Branches.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue2 = newValue;
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem1' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects1Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem2' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects2Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects3Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects3Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Sem3' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects3Bt;
                      DropdownValuesub = temp[0];
                    }
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Branch';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: DropdownButtonFormField(
                value: DropdownValuesub,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Select Subjects',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: temp.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    DropdownValuesub = newValue;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Subject';
                  }
                  return null;
                },
              ),
            ),


                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: kPrimaryColor),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {


                        FirebaseDatabase.instance.reference()
                            .child(dropdownValue3)
                            .child(dropdownValue1)
                            .child(dropdownValue2)
                            .child(DropdownValuesub)
                            .child('${nameController.text}')
                            .set({'Link': urlController.text, 'Name': nameController.text});


                    },
                    child: Text(
                      'Submit',
                      style:
                          TextStyle(fontFamily: 'Cabin', color: Colors.white),
                    ),
                  ),
                ),
              ],


        ),
      ),
    );
  }
}
