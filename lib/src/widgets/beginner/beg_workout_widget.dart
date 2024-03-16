import 'package:gym_fit/src/customicons/timer_button.dart';

import '../../models/excercise_model.dart';
import '../../resources/app_colors.dart';
import 'beg_exc_description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:achievement_view/achievement_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BegWorkoutWidget extends StatefulWidget {
  // const BegWorkoutWidget({ Key? key }) : super(key: key);
  final List<ExcerciseModel> workoutExcercises;

  BegWorkoutWidget({
    required this.workoutExcercises,
  });

  @override
  _BegWorkoutWidgetState createState() => _BegWorkoutWidgetState();
}

class _BegWorkoutWidgetState extends State<BegWorkoutWidget> {
  bool isCircle = false;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      itemCount: widget.workoutExcercises.length,
      itemBuilder: (context, index) {
        return Container(
          // height: size.size.height,
          // width: size.size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.DARK_PURPLE,
                AppColors.BRIGHT_PURPLE,
                // AppColors.LIGHT_BLACK,
                // AppColors.BLACK,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(17.h),
                height: 280.h,
                width: double.infinity,
                child: Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image(
                    image: AssetImage(widget.workoutExcercises[index].gif),
                  ), //...........................
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30.w),
                  Text(
                    widget.workoutExcercises[index].nameOfExcercise,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  // SizedBox(width: size.size.width * 0.00001),
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return BegModalSheet(
                            gif: widget.workoutExcercises[index].gif,
                            sets: widget.workoutExcercises[index].sets,
                            name_of_exercise:
                                widget.workoutExcercises[index].nameOfExcercise,
                            description:
                                widget.workoutExcercises[index].description,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.workoutExcercises[index].sets,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 65.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              if (index == 0)
                TimerButton(
                  onPressed: (data) {
                    // Handle the data here
                    print("Data received: $data");
                  },
                ),
              if (index == widget.workoutExcercises.length - 1)
                TimerButton(
                  onPressed: (data) {
                    // Handle the data here
                    print("Data received: $data");
                  },
                ),
              if (index != 0 && index != widget.workoutExcercises.length - 1)
                TimerButton(
                  onPressed: (data) {
                    // Handle the data here
                    print("Data received: $data");
                  },
                ),
              SizedBox(
                height: 10.h,
              ),
              index == widget.workoutExcercises.length - 1
                  ? ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop();
                        isCircle = true;
                        show(context);
                      },
                      child: Text(
                        'Exit',
                        style: GoogleFonts.blinker(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.linearToEaseOut);
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  void show(BuildContext context) {
    AchievementView(
      alignment: Alignment.topCenter,
      color: AppColors.LIGHT_BLACK,
      // textStyleTitle: TextStyle(fontWeight: FontWeight.bold),
      elevation: 50,
      // icon: Icon(Icons.done_all),
      duration: Duration(milliseconds: 3000),
      title: "Yeaaah!",
      subTitle: "Training completed  ",
      textStyleSubTitle: TextStyle(
        fontSize: 12.0.sp,
        // fontWeight: FontWeight.w600,
      ),
      isCircle: isCircle,
    )..show(context);
  }
}
