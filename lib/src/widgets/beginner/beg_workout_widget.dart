import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../resources/app_colors.dart';

class BegWorkoutWidget extends StatefulWidget {
  final List<> workoutExercises;
  final String selectedWorkout;

  BegWorkoutWidget({
    required this.workoutExercises,
    required this.selectedWorkout,
  });

  @override
  _BegWorkoutWidgetState createState() => _BegWorkoutWidgetState();
}

class _BegWorkoutWidgetState extends State<BegWorkoutWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  int _selectedIndex = 15; // Default to current date (15 days from start)
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 31, vsync: this, initialIndex: 15);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to generate date labels with the day name
  String getDateWithDay(int offset) {
    final now = DateTime.now().add(Duration(days: offset));
    return DateFormat('d MMM, E').format(now); // Format: 11 Sep, Sun
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    // Generate a list of 31 dates: 15 days before and 15 days after today
    List<DateTime> dateRange = List.generate(31, (index) => today.subtract(Duration(days: 15 - index)));

    return Column(
      children: [
        // Back button row
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        
        // Date picker row
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 60, // Control the height of the date picker row
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: 31,
              itemBuilder: (context, index) {
                bool isSelected = index == _selectedIndex;
                DateTime date = dateRange[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    // Scroll to center selected date
                    _scrollController.animateTo(
                      (index - 2) * 70.0, // Adjust the offset for smooth centering
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.BRIGHT_PURPLE
                          : Colors.transparent, // Highlight selected date
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd').format(date),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          DateFormat('MMM').format(date),
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          DateFormat('EEE').format(date),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // The rest of your workout content or video player
        Expanded(
          child: Center(
            child: Text(
              'Workout Content for ${DateFormat('dd MMM yyyy').format(dateRange[_selectedIndex])}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
