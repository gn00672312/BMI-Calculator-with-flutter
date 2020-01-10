import 'package:flutter/material.dart';
import 'package:bmi_calculator/theame.dart';

class ResultPage extends StatelessWidget {
  final int height;
  final int weight;
  final int gender;

  ResultPage({this.height, this.weight, this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('YOUR RESULT'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Result(this.height, this.weight, this.gender),
    );
  }
}

class Result extends StatefulWidget {
  final int height;
  final int weight;
  final int gender;

  Result(this.height, this.weight, this.gender);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("$headline", style: headlines),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      '${bmiResult(this.widget.height, this.widget.weight, this.widget.gender)}',
                      style: resultNumber),
                ),
                Column(
                  children: <Widget>[
                    Text('Normal ${genderText(this.widget.gender)} BMI range:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (this.widget.gender == 0 ? "18 - 23" : "20 - 25") +
                            " kg/m",
                        style: headlines,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$comment',
                    style: headlines,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: primaryButtonColor,
            margin: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: Text('RE-CALCULATE', style: primaryButtonStyle),
            ),
          ),
        ),
      ],
    );
  }
}

var comment = '';
var headline = '';

bmiResult(h, w, g) {
  double bmi = (w / (h * h)) * 10000;

  // default algorithm is Male.
  bool bmiUnderWeight = bmi < 20;
  bool bmiHealthyWeight = bmi >= 20 && bmi < 25;
  bool bmiOverWeight = bmi > 25 && bmi <= 29.99;

  if (g == 0) {
    bmiUnderWeight = bmi < 18;
    bmiHealthyWeight = bmi >= 18 && bmi < 23;
    bmiOverWeight = bmi > 23 && bmi <= 26.6;
  }

  if (bmiUnderWeight) {
    comment = "You are under Weight";
    headline = "UNDERWEIGHT";
  } else if (bmiHealthyWeight) {
    comment = "You are at a healthy weight.";
    headline = "NORMAL";
  } else if (bmiOverWeight) {
    comment = "You are at overweight.";
    headline = "OVERWEIGHT";
  } else {
    comment = "You are obese.";
    headline = "OBESE";
  }

  return bmi.round();
}

genderText(gender) {
  return gender == 0 ? 'Female' : 'Male';
}
