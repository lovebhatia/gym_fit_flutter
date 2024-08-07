import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_fit/src/models/exerciseRecordmodel.dart';
import 'package:gym_fit/src/models/exercise_set_model.dart';
import 'package:gym_fit/src/service/exercise_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RepsRecordScreen extends StatefulWidget {
  final String nameOfExcercise;
  RepsRecordScreen({super.key, required this.nameOfExcercise});

  @override
  _RepsRecordScreenState createState() => _RepsRecordScreenState();
}

class _RepsRecordScreenState extends State<RepsRecordScreen> {
  List<Widget> rows = [];
  int rowCount = 3; // Initial number of rows
  List<TextEditingController> weightControllers = [];
  List<TextEditingController> repsControllers = [];
  List<Map<String, dynamic>> rowData = [];
  List<ExercisePerUserModel> exerciseSets = [];

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    for (var controller in weightControllers) {
      controller.dispose();
    }
    for (var controller in repsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize rows
    print('in init state');
    for (int i = 0; i < rowCount; i++) {
      _addRow();
    }
    _fetchData();
  }

  void _addRow() {
    setState(() {
      int currentIndex = rowData.length + 1;
      Map<String, dynamic> newRowData = {
        'weight': '',
        'reps': '',
        'set': currentIndex
      };
      rowData.add(newRowData);
      TextEditingController weightController = TextEditingController();
      TextEditingController repsController = TextEditingController();
      weightControllers.add(weightController);
      repsControllers.add(repsController);
      rows.add(
        _buildRow(currentIndex),
      );
    });
  }

  void _updateRowData(int index, String field, String value) {
    setState(() {
      rowData[index][field] = value;
    });
  }

  Future<void> _sendDataToApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    var userId = extractedUserData['userId'];
     DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    Map<String, dynamic> dataToSend = {
      'exerciseName': widget.nameOfExcercise,
      'userId': userId,
      'records': rowData,
      'date': formattedDate
    };
    String jsonData = jsonEncode(dataToSend);
    final exerciseService = ExerciseService();
    await exerciseService.createExerciseSet(dataToSend);
  }

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    var userId = extractedUserData['userId'];
    final exerciseService = ExerciseService();
    try {
      List<ExercisePerUserModel> fetchedData =
          await exerciseService.fetchExerciseSets(widget.nameOfExcercise, userId);
      setState(() {
        print('in method');
        exerciseSets = fetchedData;
        rows = [];
        weightControllers.clear();
        repsControllers.clear();
        rowData.clear();
        for (var exerciseSet in exerciseSets) {
          for (var record in exerciseSet.exerciseSetRecords) {
            _addExistingRow(record);
          }
        }
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  void _addExistingRow(ExercisePeruserRecordModel record) {
    print(record.reps);
    setState(() {
      Map<String, dynamic> newRowData = {
        'weight': record.weight.toString(),
        'reps': record.reps.toString(),
        'set': record.set
      };
      rowData.add(newRowData);
      TextEditingController weightController =
          TextEditingController(text: record.weight.toString());
      TextEditingController repsController =
          TextEditingController(text: record.reps.toString());
      weightControllers.add(weightController);
      repsControllers.add(repsController);
      rows.add(
        _buildRow(record.set),
      );
    });
  }

  Widget _buildRow(int index) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[800]!),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
            const SizedBox(width: 8),
            Container(
              width: 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: weightControllers[index - 1],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
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
                  const SizedBox(width: 10),
                  Text(
                    'Kg',
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
            const SizedBox(width: 10),
            Container(
              width: 120,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: repsControllers[index - 1],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
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
                  const SizedBox(width: 8),
                  Text(
                    'REPS',
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addRow();
                  },
                  child: const Text('Add More Sets'),
                ),
                const SizedBox(width: 10), // Spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    //_save(this.rowData);
                    _sendDataToApi();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
