import 'package:flutter/material.dart';

import '../models/exam_model.dart';
import 'exam_card.dart';

class ExamGrid extends StatelessWidget{

  final List<ExamModel> exams;

  const ExamGrid({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ExamCard(exam: exams[index]),
      separatorBuilder: (context, index) => SizedBox(height: 5),
      itemCount: exams.length,
    );

  }


}