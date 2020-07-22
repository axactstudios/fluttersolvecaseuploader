import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown";

  @override
  DropDownState createState() => DropDownState();
}

class Semester {
  int id;
  String name;

  Semester(this.id, this.name);

  static List<Semester> getSemester() {
    return <Semester>[
      Semester(1, 'First'),
      Semester(2, 'Second'),
      Semester(3, 'Third'),
      Semester(4, 'Fourth'),

    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Semester> _semesters = Semester.getSemester();
  List<DropdownMenuItem<Semester>> _dropdownMenuItems;
  Semester _selectedSemester;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_semesters);
    _selectedSemester = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Semester>> buildDropdownMenuItems(List semesters) {
    List<DropdownMenuItem<Semester>> items = List();
    for (Semester semester in semesters) {
      items.add(
        DropdownMenuItem(
          value: semester,
          child: Text(semester.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Semester selectedSemester) {
    setState(() {
      _selectedSemester = selectedSemester;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("SOLVECASE UPLOADER"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select a semester"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedSemester,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Selected: ${_selectedSemester.name}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}