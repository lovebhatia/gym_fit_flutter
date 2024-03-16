import 'package:gym_fit/src/screens/reps/rep_record_screen.dart';
import 'package:gym_fit/src/screens/video_screen.dart';
import '../../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BegModalSheet extends StatelessWidget {
  // const BegModalSheet({ Key? key }) : super(key: key);
  final String gif;
  final String name_of_exercise;
  final String sets;
  final String description;

  BegModalSheet({
    required this.gif,
    required this.name_of_exercise,
    required this.sets,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          Container(
            height: 500.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.BLACK,
                  AppColors.LIGHT_BLACK,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.0.w, right: 25.w),
                  child: Container(
                    padding: EdgeInsets.only(top: 32),
                    height: 200.h,
                    width: 350.w,
                    child: Card(
                        elevation: 25,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: VideoScreen()
                        /* Image(
                      image: AssetImage(gif),
                    ), 
                    */
                        ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name_of_exercise, //........................................
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10.0.h, left: 27.w, right: 22.w),
                  child: RepsRecordScreen(name_of_exercise),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
