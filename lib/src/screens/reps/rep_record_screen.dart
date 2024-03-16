import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RepsRecordScreen extends StatefulWidget {
  RepsRecordScreen(String nameOfExcercise);

  @override
  _RepsRecordScreenState createState() => _RepsRecordScreenState();
}

class _RepsRecordScreenState extends State<RepsRecordScreen> {
  List<Widget> rows = [];
  int rowCount = 3; // Initial number of rows
  TextEditingController setsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  List<TextEditingController> weightControllers = [];
  List<TextEditingController> repsControllers = [];
  List<Map<String, dynamic>> rowData = [];

  String selectedReps = '';
  String selectedWeights = '';

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    setsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize rows
    for (int i = 0; i < rowCount; i++) {
      _addRow();
    }
  }

  void _addRow() {
    setState(() {
      Map<String, dynamic> newRowData = {
        'weight': '',
        'reps': '',
      };
      rowData.add(newRowData);

      // Create new controllers for each new row
      TextEditingController weightController = TextEditingController();
      TextEditingController repsController = TextEditingController();

      weightControllers.add(weightController);
      repsControllers.add(repsController);

      rows.add(
        _buildRow(rows.length + 1),
      );
    });
  }

  void _updateRowData(int index, String field, String value) {
    print(field + "---" + value);
    setState(() {
      rowData[index][field] = value;
    });
    print(rowData.toString());
  }

  void _sendDataToApi() {
    //convert rowData to json
    String jsonData = jsonEncode(rowData);
  }

  Widget _buildRow(int index) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[800]!),
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: weightControllers[index - 1],
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _updateRowData(index - 1, 'weight', newValue);
                        });
                      },
                      onEditingComplete: () {
                        // Move focus to the next text field
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Kg', //........................................
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 120,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: repsControllers[index - 1],
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _updateRowData(index - 1, 'reps', newValue);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'REPS', //........................................
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 600, // Ensure that the container takes the full width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //color: Colors.grey[800], // Background color of the table
              child: Column(
                children: rows,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addRow();
                },
                child: const Text('Add More Sets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
