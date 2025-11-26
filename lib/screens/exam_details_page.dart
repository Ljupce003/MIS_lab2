import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/exam_model.dart';
import '../widgets/details_page_adaptive_appbar.dart';


class ExamDetailsPage extends StatelessWidget {
  const ExamDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ExamModel exam = ModalRoute.of(context)!.settings.arguments as ExamModel;

    String formatedDateTime = DateFormat(
      "dd MMM yyyy, HH:mm",
    ).format(exam.dateTime);

    String formatedTime = formatedDateTime.split(", ")[1];

    int minuteDiff = exam.dateTime.difference(DateTime.now()).inMinutes;

    int daysRounded = minuteDiff ~/ 1440;
    int hoursRounded = (minuteDiff % 1440) ~/ 60;
    int minuteRounded = minuteDiff % 60;

    bool isExpired = DateTime.now().isAfter(exam.dateTime);

    return Scaffold(
      appBar: ExamAppBar(isExpired: isExpired, exam: exam),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Простории",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              ...List.generate(
                exam.examRooms.length,
                (index) => Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Icon(Icons.location_pin),
                      Text("${exam.examRooms[index]} $formatedTime"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Датум и време",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined),
                    SizedBox(width: 5),
                    Text(formatedDateTime),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text("Преостанато: "),
                    Text(
                      "$daysRounded дена, $hoursRounded часови, $minuteRounded минути",
                      style: TextStyle(
                        color: isExpired ? Colors.red : Colors.black,fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
