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
    "First",
    "Second",
    "Third",
  ];
  final College = ['JIIT-62', 'JIIT-128'];
  final listOfSubjects1Cse = [
    "A",
    "B",
    "C",
    "D",
  ];
  final listOfSubjects2Cse = [
    "E",
    "F",
    "G",
    "H",
  ];
  final listOfSubjects3Cse = [
    "I",
    "J",
    "K",
    "L",
  ];

  final listOfSubjects1Ece = [
    "M",
    "N",
    "O",
    "P",
  ];
  final listOfSubjects2Ece = [
    "Q",
    "R",
    "S",
    "T",
  ];
  final listOfSubjects3Ece = [
    "U",
    "V",
    "W",
    "X",
  ];
  final listOfSubjects1Bt = [
    "Y",
    "Z",
    "Z1",
    "Z2",
  ];
  final listOfSubjects2Bt = [
    "Z3",
    "Z4",
    "Z5",
    "Z6",
  ];
  final listOfSubjects3Bt = [
    "Z7",
    "Z8",
    "Z9",
    "Z10",
  ];
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  final Branches = ['CSE', 'ECE', 'BT'];
  String dropdownValue1 = 'First';
  String dropdownValue3 = 'JIIT-62';
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final quantity = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference();
  String dropdownValue2 = 'CSE';
  List<String> temp = ['A', 'B', 'C', 'D'];
  String DropdownValuesub = 'A';
  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;

    if (fileType == 'pdf') {
      storageReference = FirebaseStorage.instance.ref().child("pdf/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(
            type: FileType.custom, allowedExtensions: ['pdf']);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

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
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects1Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects1Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects2Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects2Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects3Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects3Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'BT') {
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
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects1Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects1Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'First' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects1Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects2Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects2Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Second' && dropdownValue2 == 'BT') {
                      temp = listOfSubjects2Bt;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'CSE') {
                      temp = listOfSubjects3Cse;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'ECE') {
                      temp = listOfSubjects3Ece;
                      DropdownValuesub = temp[0];
                    }
                    if (dropdownValue1 == 'Third' && dropdownValue2 == 'BT') {
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
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 2.0, 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: kPrimaryColor),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {
                      setState(() {
                        fileType = 'any';
                      });
                      filePicker(context);
                    },
                    child: Text(
                      'Select',
                      style:
                          TextStyle(fontFamily: 'Cabin', color: Colors.white),
                    ),
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
                      int price1 = int.parse(ageController.text);
                      if (_formKey.currentState.validate()) {
                        dbRef
                            .child(dropdownValue1)
                            .child(nameController.text)
                            .update({
                          "Name": nameController.text,
                        }).then((_) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added')));
                          ageController.clear();
                          nameController.clear();
                        }).catchError((onError) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(onError)));
                        });
                      }
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
          ],
        ),
      ),
    );
  }
}
