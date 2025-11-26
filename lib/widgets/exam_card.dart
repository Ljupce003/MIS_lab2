import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/exam_model.dart';

class ExamCard extends StatelessWidget{

  final ExamModel exam;

  const ExamCard({super.key, required this.exam});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator
          .pushNamed(context, "/details", arguments: exam),
      child: Card(
        child: ListTile(
          title: Text(exam.name),

          subtitle: Column(
            children: List.generate(
              exam.examRooms.length,
                  (roomId) => Row(
                children: [
                  Icon(Icons.location_pin),
                  Text(exam.examRooms[roomId]),
                ],
              ),
            ),
          ),

          trailing: Wrap(
            spacing: 3,
            children: [
              Icon(Icons.timer_outlined, size: 18),

              Text(
                DateFormat(
                  'dd MMM yyyy, HH:mm',
                ).format(exam.dateTime),
                style: TextStyle(
                  color:
                  exam.dateTime.isBefore(DateTime.now())
                      ? Colors.red
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}