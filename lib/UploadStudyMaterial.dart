import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersolvecaseuploader/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial({Key key}) : super(key: key);

  @override
  _UploadStudyMaterialState createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  final _formKey = GlobalKey<FormState>();
  final College = ['JIIT', 'JIIT-128'];
  final listOfCategories1 = ['Sem1', 'Sem2', 'Sem3'];
  final Branches = ['CSE', 'ECE', 'BT'];
  final listOfSubjects1Cse = [
    'Mathematics-1',
    'Physics-1 ',
    'SDF-1',
    'English',
    'Physics Lab-1 ',
    'SDF LAB -1',
    'EDD',
    'Workshop'
  ];
  final listOfSubjects2Cse = [
    "Mathematics-2",
    "Physics-2",
    "Electrical Science-I",
    "SDF-2",
    "Physics Lab-2",
    "Electrical Science Lab-I",
    "SDF LAB-2",
    "Workshop",
    "EDD"
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

  ProgressDialog pr;

  String dropdownValue1 = 'Sem1';
  String dropdownValue2 = 'CSE';
  String dropdownValue3 = 'JIIT';

  final nameController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.reference();

  List<String> temp = [
    'Mathematics-1',
    'Physics-1 ',
    'SDF-1',
    'English',
    'Physics Lab-1 ',
    'SDF LAB -1',
    'EDD',
    'Workshop'
  ];
  String DropdownValuesub = 'Mathematics-1';

  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;

    storageReference = FirebaseStorage.instance
        .ref()
        .child(dropdownValue3)
        .child(dropdownValue1)
        .child(dropdownValue2)
        .child(DropdownValuesub)
        .child("Study Material/$filename");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: false,
    );
    pr.style(
      message: 'Uploading...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
    pr.update(
      progress: 30.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    pr.update(
      progress: 70.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.hide();
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);

    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    dbRef
        .child(dropdownValue3)
        .child(dropdownValue1)
        .child(dropdownValue2)
        .child(DropdownValuesub)
        .child('${nameController.text}')
        .set({'Link': url, 'Name': nameController.text});
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'any') {
        file = await FilePicker.getFile(
            type: FileType.custom, allowedExtensions: ['any']);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
        Fluttertoast.showToast(
            msg: 'FILE SELECTED',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,

            backgroundColor: Colors.transparent,
            textColor: Colors.black
        );
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
                  labelText: 'Enter File Name',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter File Name';
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
                    print(dropdownValue1);
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
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 2.0, 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: kPrimaryColor),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {



                      if (_formKey.currentState.validate()) {
                        dbRef
                            .child(dropdownValue1)
                            .child(nameController.text)
                            .update({
                          "Name": nameController.text,
                        }).then((_) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added')));

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
