import 'package:gym_fit/src/calculator_brain.dart';
import 'package:gym_fit/src/components/reusable_card.dart';
import 'package:gym_fit/src/components/round_icon_button.dart';
import 'package:gym_fit/src/screens/BMI/results_page.dart';

import '../../animations/transitions.dart';
import '../../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/icon_content.dart';
import '../../constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Gender {
  male,
  female,
}

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  late Gender selectedGender = Gender.male;
  int height = 180;
  int weight = 60;
  int age = 20;

  void updateGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void updateHeight(double newHeight) {
    setState(() {
      height = newHeight.round();
    });
  }

  void updateWeight(int newWeight) {
    setState(() {
      weight = newWeight;
    });
  }

  void updateAge(int newAge) {
    setState(() {
      age = newAge;
    });
  }

  void decreaseWeight() {
    setState(() {
      weight--;
    });
  }

  void increaseWeight() {
    setState(() {
      weight++;
    });
  }

  void decreaseAge() {
    setState(() {
      age--;
    });
  }

  void increaseAge() {
    setState(() {
      age++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BLACK,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.BLACK,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors.BLACK,
            elevation: 0,
            title: Text(
              'BMI CALCULATOR',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.h, left: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BMI',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 3),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'CALCULATOR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                          color: Color(0xfff953c6),
                          letterSpacing: 3),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        updateGender(Gender.male);
                      },
                      child: ReusableCard(
                        onPress: () {},
                        gradient: selectedGender == Gender.male
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mars,
                          label: 'MALE',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        updateGender(Gender.female);
                      },
                      child: ReusableCard(
                        onPress: () {},
                        gradient: selectedGender == Gender.female
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.venus,
                          label: 'FEMALE',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ReusableCard(
                gradient: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: Colors.white,
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 13.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                onPress: () {},
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      gradient: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    updateWeight(weight - 1);
                                  },
                                  // Wrap with Expanded widget
                                  child: RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {}),
                                ),
                              ),
                              SizedBox(
                                width: 10.0.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    updateWeight(weight + 1);
                                  },
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onPress: () {},
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      gradient: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Age',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    updateAge(age - 1);
                                  },
                                  // Wrap with Expanded widget
                                  child: RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {}),
                                ),
                              ),
                              SizedBox(
                                width: 10.0.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    updateAge(age + 1);
                                  },
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onPress: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 105.w, right: 105.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 15,
                    backgroundColor: Colors.transparent,
                    shadowColor: AppColors.LIGHT_BLACK,
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    CalculatorBrain calc =
                        CalculatorBrain(height: height, weight: weight);

                    Navigator.push(
                      context,
                      SlideLeftTransition(
                        ResultsPage(
                          bmiResult: calc.calculateBMI(),
                          resultText: calc.getResult(),
                          interpretation: calc.getInterpretation(),
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffaa076b),
                          Color(0xff61045f),
                        ],
                        // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    child: Container(
                      constraints:
                          BoxConstraints(minWidth: 108.w, minHeight: 36.0.h),
                      padding: EdgeInsets.all(12.h),
                      alignment: Alignment.center,
                      child: Text(
                        'CALCULATE',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18.sp, // Adjusted font size
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.white, // Ensure contrast with background
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
