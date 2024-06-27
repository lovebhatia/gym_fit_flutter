import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_fit/src/models/exerciseRecordmodel.dart';
import 'package:gym_fit/src/models/exercise_set_model.dart';
import 'package:gym_fit/src/service/exercise_service.dart';

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
  TextEditingController setsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  List<TextEditingController> weightControllers = [];
  List<TextEditingController> repsControllers = [];
  List<Map<String, dynamic>> rowData = [];
  List<ExerciseSetmodel> exerciseSets = [];

  String selectedReps = '';
  String selectedWeights = '';

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    //setsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize rows
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
    Map<String, dynamic> dataToSend = {
      'exercise_name': widget.nameOfExcercise,
      'records': rowData,
    };
    String jsonData = jsonEncode(dataToSend);

    final exerciseService = ExerciseService();
    await exerciseService.createExerciseSet(dataToSend);
  }

  Future<void> _fetchData() async {
    final exerciseService = ExerciseService();
    try {
      List<ExerciseSetmodel> fetchedData =
          await exerciseService.fetchExerciseSets();
      setState(() {
        exerciseSets = fetchedData;
        rows = [];
        for (var exerciseSet in exerciseSets) {
          for (var record in exerciseSet.records) {
            _addExistingRow(record);
          }
        }
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  void _addExistingRow(ExerciseRecordModel record) {
    setState(() {
      Map<String, dynamic> newRowData = {
        'weight': record.weight.toString(),
        'reps': record.reps.toString(),
        'set': record.index
      };
      rowData.add(newRowData);
      TextEditingController weightController =
          TextEditingController(text: record.weight.toString());
      TextEditingController repsController =
          TextEditingController(text: record.reps.toString());
      weightControllers.add(weightController);
      repsControllers.add(repsController);
      rows.add(
        _buildRow(record.index),
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

// Add your _save method implementation here
  void _save(rowdata) {
    // Your save logic
  }
}
